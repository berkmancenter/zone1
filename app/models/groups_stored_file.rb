class GroupsStoredFile < ActiveRecord::Base
  belongs_to :stored_file
  belongs_to :group

  validates_presence_of :stored_file, :on => :update
  validates_presence_of :group

  attr_accessible :group_id, :stored_file_id, :checked
  
  attr_reader :checked

  def checked=(boolean)
    #When creating a new flagging, we need a way to tell the form
    #whether or not to check the checkbox
    #This is specifically for creating flaggings for bulk edit
    raise "checked= is only to be used on new records" if !new_record?

    @checked ||= !!boolean
  end

  def checked?
    #if the record has been saved, we want the form's checkbox to be checked
    return new_record? ? !!@checked : true
  end

end
