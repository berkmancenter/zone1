class RightAssignment < ActiveRecord::Base
  belongs_to :right
  belongs_to :subject, :polymorphic => true
  attr_accessible :right_id

  after_create :destroy_cache
  after_destroy :destroy_cache

  private
  def destroy_cache
    Rails.cache.delete("#{subject_type.tableize}-viewable-users-#{right.action}")
    if subject.is_a? Role and subject.name == "user"
      Rails.cache.delete("user-rights")
      Rails.cache.delete_matched(%r{user-rights-*})
    end  
    if right.action == "view_preserved_flag_content"
      flags = Flag.preservation.map(&:id)
      StoredFile.unscoped.joins(:flaggings).where(:"flaggings.flag_id" => flags).each do |f|
        Rails.logger.debug "Destroying_cache on stored_file: #{f.id}"
        f.send :destroy_cache
      end
    end
  end
end
