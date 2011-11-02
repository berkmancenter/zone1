class Flagging < ActiveRecord::Base
  belongs_to :flag
  belongs_to :stored_file

  validates_presence_of :flag_id
  validates_presence_of :user_id
  validates_presence_of :stored_file_id
end
