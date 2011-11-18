class Flagging < ActiveRecord::Base
  belongs_to :flag
  belongs_to :stored_file
  belongs_to :user

  validates_presence_of :flag_id
  validates_presence_of :user_id
  validates_presence_of :stored_file_id, :on => :update #we won't have this when creating

  attr_accessible :flag_id, :user_id, :stored_file_id, :note, :checked

  attr_reader :checked

  def checked=(boolean)
    #When creating a new flagging, we need a way to tell the form
    #whether or not to check the checkbox
    #This is specifically for creating flaggings for bulk edit

    raise "checked= is only to be used on new records" if !new_record?

    @checked ||= !!boolean  #!! will convert input to boolean
  end

  def checked?
    if new_record?
      return @checked==true
    else
      return true  #if the record has been saved, we want the form's checkbox to be checked
    end
  end

end
