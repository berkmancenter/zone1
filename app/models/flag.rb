class Flag < ActiveRecord::Base
  validates_presence_of :name, :label
  validates_uniqueness_of :name

  attr_accessible :name, :label

  PRESERVED = ["NOMINATED_FOR_PRESERVATION", "PRESERVED", "SELECTED_FOR_PRESERVATION"]
  # TODO: Maybe come up with a better name for this
  SELECTED = ["SELECTED_FOR_PRESERVATION", "UNIVERSITY_RECORD"]

  # Caching related callbacks
  after_save :destroy_cache
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
    self.all.detect { |l| l.id == value.to_i }.label
  end

  def self.preservation
    Flag.find_all_by_name(PRESERVED)
  end

  def self.selected
    Flag.find_all_by_name(SELECTED)
  end

  private

  def destroy_cache
    Rails.cache.delete("flags")
  end
end
