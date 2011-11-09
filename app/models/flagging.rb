class Flagging < ActiveRecord::Base
  belongs_to :flag
  belongs_to :stored_file
  belongs_to :user

  validates_presence_of :flag_id
  validates_presence_of :user_id
  validates_presence_of :stored_file_id, :on => :update #we won't have this when creating

  attr_accessible :flag_id, :user_id, :stored_file_id, :note
end
