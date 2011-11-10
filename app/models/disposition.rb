class Disposition < ActiveRecord::Base
  belongs_to :disposition_action
  belongs_to :stored_file

  validates_presence_of :disposition_action_id
  validates_presence_of :stored_file_id

  attr_accessible :stored_file_id, :disposition_action_id, :location, :note
end
