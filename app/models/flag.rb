class Flag < ActiveRecord::Base

  has_many :flaggings  # can't use :dependent => :destroy. see reindex_flagged_stored_files()
  validates_presence_of :name, :label
  validates_uniqueness_of :name

  attr_accessible :name, :label

  PRESERVED = ["NOMINATED_FOR_PRESERVATION", "PRESERVED", "SELECTED_FOR_PRESERVATION"]
  SELECTED = ["SELECTED_FOR_PRESERVATION", "UNIVERSITY_RECORD"]

  # Caching related callbacks
  after_save :destroy_cache
  before_destroy { |record| Flag.reindex_flagged_stored_files(record) }
  after_destroy :destroy_cache

  def self.preserved
    Flag.find_by_name("PRESERVED")
  end
  def self.nominated_preservation
    Flag.find_by_name("NOMINATED_FOR_PRESERVATION")
  end
  def self.selected_preservation
    Flag.find_by_name("SELECTED_FOR_PRESERVATION")
  end
  def self.univ_record
    Flag.find_by_name("UNIVERSITY_RECORD")
  end
  def self.may_be_univ_record
    Flag.find_by_name("MAY_BE_UNIVERSITY_RECORD")
  end

  def self.all
    Rails.cache.fetch("flags") do
      Flag.find(:all)
    end
  end

  def self.facet_label(value)
    # Use try() here to prevent stale Solr data from asking for a flag that's been deleted
    self.all.detect { |l| l.id == value.to_i }.try :label
  end

  def self.preservation
    Flag.find_all_by_name(PRESERVED)
  end

  def self.selected
    Flag.find_all_by_name(SELECTED)
  end

  def self.reindex_flagged_stored_files(flag)
    # Remove this flag's flaggings from flagged stored_files and reindex those
    # stored_files. This updates Solr's indexed flag data for just the relevant
    # files and prevents an app error. We try to use lightweight methods here, as
    # this could involve a lot of heavy lifting for a popular flag. (The entire
    # destroy job could be done in a Resque job if this got too slow.)
    stored_file_ids = self.connection.select_all("SELECT stored_file_id
      FROM flaggings
      WHERE flaggings.flag_id = '#{flag.id}'").collect {|row| row['stored_file_id'].to_i}

    # nothing to do
    return true if stored_file_ids.length == 0
    
    Flagging.delete_all(:stored_file_id => stored_file_ids, :flag_id => flag.id)

    # unscoped because we want to update soft-deleted StoredFiles too
    StoredFile.unscoped.find(stored_file_ids).each {|stored_file| stored_file.reindex_sunspot }

    true
  end


  private

  def destroy_cache
    Rails.cache.delete("flags")
  end
end
