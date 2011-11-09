class GroupsStoredFile < ActiveRecord::Base
  belongs_to :stored_file
  belongs_to :group

  validates_presence_of :stored_file, :on => :update #won't have this when creating
  validates_presence_of :group

  attr_accessible :group_id, :stored_file_id
end
