# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.transaction do

  puts "Generating preferences"
  Preference.create :name => "default_user_upload_quota", :label => "Default User Upload Quota (Bytes)", :value => "10485760"
  Preference.create :name => "soft_delete_retention_period", :label => "Retention Period (Days)", :value => "1825"
  Preference.create :name => "max_web_upload_filesize", :label => "Max Web Upload Filesize (with units)", :value => "250mb"
  Preference.create :name => "default_license", :label => "Default License Name", :value => "CC BY"
  Preference.create :name => "group_invite_from_address", :label => "Group Invite Email From Address", :value => "group_invites@zoneone.domain"
  Preference.create :name => "group_invite_pending_duration", :label => "Group Invite Pending Invite Expiration (Days)", :value => "90"
  Preference.create :name => "sftp_user_home_directory_root", :label => "SFTP User Home Directory Root (Absolute Path)", :value => "/home/sftp/uploads"
  Preference.create :name => "fits_script_path", :label => "FITS script Full Path", :value => "#{Rails.root}/bin/fits-0.6.0/fits.sh"
  Preference.create :name => "sftp_server_name", :label => "SFTP Full Hostname or IP address", :value => "174.37.104.41"

  puts "Generating MimeTypeCategories"
  #http://www.iana.org/assignments/media-types/index.html
  %w(Application Audio Image Text Video Document Uncategorized).each do |category_name|
    MimeTypeCategory.create(:name => category_name)
  end
  (application, audio, image, text, video, document, uncategorized) = MimeTypeCategory.all

  puts "Generating MimeTypeBlacklist"
  MimeType.create(:name => "DOS executable", :mime_type => "application/x-dosexec", :blacklist => true, :extension => ".com")

  puts "Generating MimeTypes"
  MimeType.create(:name => "JPEG Image File Format", :mime_type => "image/jpeg", :extension => ".jpg")
  MimeType.create(:name => "Portable Network Graphics", :mime_type => "image/png", :extension => ".png")
  MimeType.create(:name => "Graphics Interchange Format", :mime_type => "image/gif", :extension => ".gif")
  MimeType.create(:name => "Tagged Image File Format", :mime_type => "image/tiff", :extension => ".tif")
  MimeType.create(:name => "Scalable Vector Graphics", :mime_type => "image/svg+xml", :extension => ".svg")
  MimeType.create(:name => "Windows Bitmap", :mime_type => "image/bmp", :extension => ".bmp")
  MimeType.create(:name => "Photoshop", :mime_type => "image/vnd.adobe.photoshop", :extension => ".psd")

  MimeType.create(:extension => ".ivf", :name => "AVI", :mime_type => "video/avi")
  MimeType.create(:extension => ".mpg", :name => "MPEG", :mime_type => "video/mpeg")
  MimeType.create(:extension => ".mpeg", :name => "MPEG", :mime_type => "video/mpeg")
  MimeType.create(:extension => ".m1v", :name => "MPEG", :mime_type => "video/mpeg")
  MimeType.create(:extension => ".mpe", :name => "MPEG", :mime_type => "video/mpeg")
  MimeType.create(:extension => ".wmv", :name => "WMV", :mime_type => "video/x-ms-wmv")
  MimeType.create(:extension => ".flv", :name => "Flash Video", :mime_type => "video/x-flv")
  MimeType.create(:extension => ".avi", :name => "AVI", :mime_type => "video/avi")
  MimeType.create(:extension => ".m4v", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4")
  MimeType.create(:extension => ".3g2", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4")
  MimeType.create(:extension => ".3gp", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4")
  MimeType.create(:extension => ".mp4", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4")
  MimeType.create(:extension => ".mov", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4")
  MimeType.create(:extension => ".m2v", :name => "MPEG", :mime_type => "video/mpeg")

  MimeType.create(:name => "MPEG-4 Audio", :mime_type => "audio/mp4", :extension => ".m4a")
  MimeType.create(:name => "Waveform Audio", :mime_type => "audio/x-wave", :extension => ".wav")
  MimeType.create(:name => "NeXt Sound File", :mime_type => "application/octet-stream", :extension => ".snd", :mime_type_category_id => audio.id)
  MimeType.create(:name => "Unix Sound File", :mime_type => "audio/basic", :extension => ".au")
  MimeType.create(:extension => ".aifc", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff")
  MimeType.create(:extension => ".aif", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff")
  MimeType.create(:extension => ".aiff", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff")
  MimeType.create(:name => "RIFF", :mime_type => "application/octet-stream", :extension => ".rmi", :mime_type_category_id => audio.id)
  MimeType.create(:name => "MIDI Audio", :mime_type => "audio/midi", :extension => ".mid")
  MimeType.create(:name => "Midi", :mime_type => "audio/unkown", :extension => ".midi")
  MimeType.create(:extension => ".mpa", :name => "MPEG 1/2 Audio Layer 3", :mime_type => "audio/mpeg")
  MimeType.create(:extension => ".mp3", :name => "MPEG 1/2 Audio Layer 3", :mime_type => "audio/mpeg")
  MimeType.create(:extension => ".wma", :name => "WMA", :mime_type => "audio/x-ms-wma")

  MimeType.create(:name => "Comma seperated values", :mime_type => "text/plain", :extension => ".csv")
  MimeType.create(:name => "Extensible Markup Language", :mime_type => "text/xml", :extension => ".xml")
  MimeType.create(:name => "Plain text", :mime_type => "text/plain", :extension => ".txt")
  MimeType.create(:name => "Rich text format", :mime_type => "text/plain", :extension => ".rtf")
  MimeType.create(:name => "Hypertext Markup Language", :mime_type => "text/html", :extension => ".html")

  MimeType.create(:name => "Portable Document Format", :mime_type => "application/pdf", :extension => ".pdf", :mime_type_category_id => document.id)
  MimeType.create(:name => "Word X", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".docx", :mime_type_category_id => document.id)
  MimeType.create(:name => "Excel X", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".xlsx", :mime_type_category_id => document.id)
  MimeType.create(:name => "Word", :mime_type => "application/msword", :extension => ".doc", :mime_type_category_id => document.id)
  MimeType.create(:name => "Excel", :mime_type => "application/vnd.ms-excel", :extension => ".xls", :mime_type_category_id => document.id)
  MimeType.create(:name => "Powerpoint", :mime_type => "application/vnd.ms-powerpoint", :extension => ".ppt", :mime_type_category_id => document.id)
  MimeType.create(:name => "Powerpoint X", :mime_type => "vnd.oasis.opendocument.text", :extension => ".pptx", :mime_type_category_id => document.id)

  MimeType.create(:name => "RAR Format", :mime_type => "application/x-rar-compressed", :extension => ".rar")
  MimeType.create(:name => "Zip Format", :mime_type => "application/zip", :extension => ".zip")

  #special case of a non-text file with no file extension
  MimeType.create(:name => "Unknown Binary", :mime_type => "application/octet-stream", :extension => "")

  puts "Generating disposition actions"
  DispositionAction.create([{ :action => "DELETE" },
                            { :action => "REVIEW" },
                            { :action => "TRANSFER" }])

  puts "Generating access levels"
  AccessLevel.create([{ :name => 'open', :label => 'Open' },
                      { :name => 'dark', :label => 'Dark' },
                      { :name => 'partially_open', :label => 'Partially Open' }])
  (a1, a2, a3) = AccessLevel.all

  puts "Generating flags"
  Flag.create([{ :name => 'NOMINATED_FOR_PRESERVATION', :label => 'Nominated for Preservation' },
              { :name => 'SELECTED_FOR_PRESERVATION', :label => 'Selected for Preservation' },
              { :name => 'PRESERVED', :label => 'Preserved' },
              { :name => 'MAY_BE_UNIVERSITY_RECORD', :label => 'May be University Record' },
              { :name => 'UNIVERSITY_RECORD', :label => 'University Record' }])

  #Roles are needed before users because user role is automatically added to new users
  puts "Generating roles"
  Role.create([{ :name => "admin" },
    { :name => "steward" },
    { :name => "records_manager" },
    { :name => "user" }])
  (role_admin, role_steward, role_records_manager, role_user) = Role.all

  puts "Generating Admin user"
  admin_user = User.create :email => 'admin@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Admin'
  admin_user.roles << role_admin

  puts "Generating rights"
  Right.create([{ :action => "add_preserved", :description => "Ability to add PRESERVED flag." },
    { :action => "add_nominated_for_preservation", :description => "Ability to add NOMINATED_FOR_PRESERVATION flag." },
    { :action => "add_selected_for_preservation", :description => "Ability to add SELECTED_FOR_PRESERVATION flag." },
    { :action => "add_university_record", :description => "Ability to add UNIVERSITY_RECORD flag." },
    { :action => "add_may_be_university_record", :description => "Ability to add MAY_BE_UNIVERSITY_RECORD flag." },
    { :action => "toggle_open", :description => "Ability to set access level to open on any content." },
    { :action => "toggle_open_on_owned", :description => "Ability to set access level to open on content owned by you." },
    { :action => "toggle_partially_open", :description => "Ability to set access level to partially open on any content." },
    { :action => "toggle_partially_open_on_owned", :description => "Ability to set access level to partially open on content owned by you." },
    { :action => "toggle_dark", :description => "Ability to set access level to dark on any content." },
    { :action => "toggle_dark_on_owned", :description => "Ability to set access level to dark on content owned by you." },
    { :action => "manage_disposition", :description => "Ability to update disposition on any content." },
    { :action => "delete_items", :description => "Ability to delete any content." },
    { :action => "delete_items_on_owned", :description => "Ability to delete content owned by you." },
    { :action => "view_items", :description => "Ability to view any content." }, 
    { :action => "view_items_on_owned", :description => "Ability to view content owned by you." },
    { :action => "view_preserved_flag_content", :description => "Ability to view any content with preservation flag." },
    { :action => "delete_comments", :description => "Ability to manage comments on any content." },
    { :action => "delete_comments_on_owned", :description => "Ability to manage comments on content owned by you." },
    { :action => "edit_items", :description => "Ability to edit metadata of any content." },
    { :action => "edit_items_on_owned", :description => "Ability to edit metadata on content owned by you." },
    { :action => "edit_groups", :description => "Ability to edit metadata and members of any group." },
    { :action => "edit_groups_on_owned", :description => "Ability to edit metadata and members on groups owned by you." },
    { :action => "view_reports", :description => "Ability to view any reports."},
    { :action => "view_reports_on_owned", :description => "Ability to view reports on content owned by you."},
    { :action => "view_admin", :description => "Ability to view admin interface."},
    { :action => "remove_preserved", :description => "Ability to remove PRESERVED flag." },
    { :action => "remove_nominated_for_preservation", :description => "Ability to remove NOMINATED_FOR_PRESERVATION flag." },
    { :action => "remove_selected_for_preservation", :description => "Ability to remove SELECTED_FOR_PRESERVATION flag." },
    { :action => "remove_university_record", :description => "Ability to remove UNIVERSITY_RECORD flag." },
    { :action => "remove_may_be_university_record", :description => "Ability to remove MAY_BE_UNIVERSITY_RECORD flag." },
    { :action => "edit_group_rights", :description => "Ability to assign rights to groups."}])
  (ri1, ri2, ri3, ri4, ri5, ri6, ri7, ri8, ri9, ri10,
   ri11, ri12, ri13, ri14, ri15, ri16, ri17, ri18, ri19, ri20,
   ri21, ri22, ri23, ri24, ri25, ri26, ri27, ri28, ri29, ri30,
   ri31) = Right.all

  role_admin.rights = Right.all
  role_admin.save
  role_steward.rights = [ri1, ri2, ri3, ri17, ri27, ri28, ri29] # preservation flags, view preserved flag content
  role_steward.save
  role_records_manager.rights = [ri4, ri5, ri6, ri8, ri10, ri12, ri15, ri30, ri31] #university flags, accessibility, view any content, manage_dispositions
  role_records_manager.save
  role_user.rights = [ri2, ri5, ri9, ri11, ri14, ri16, ri19, ri21, ri23, ri25] #nominate preservation flag, partially open and dark settings, view own content, manage own comments 
  role_user.save

  puts "Generating licenses"
  License.create([{ :name => 'All Rights Reserved' },
          { :name => 'Public Domain' },
          { :name => 'CC BY' }])

end
