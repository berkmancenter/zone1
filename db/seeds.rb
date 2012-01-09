# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

AccessLevel.delete_all
Flag.delete_all
User.delete_all
Group.delete_all
StoredFile.delete_all
Role.delete_all
Right.delete_all
Disposition.delete_all
Preference.delete_all
DispositionAction.delete_all
License.delete_all
MimeType.delete_all
MimeTypeCategory.delete_all

connection = ActiveRecord::Base.connection
connection.execute("DELETE FROM roles_users")

puts "Generating preferences"
Preference.create([{:name => "Default User Upload Quota", :value => "10485760" }])
Preference.create([{:name => "Retention Period", :value => "1825" }])
Preference.create([{:name => "Max Web Upload Filesize", :value => "10mb" }])
Preference.create :name => "Default License", :value => "CC BY"


puts "Generating MimeTypeCategories"
#http://www.iana.org/assignments/media-types/index.html
%w(Application Audio Image Text Video Document Uncategorized).each do |category_name|
  MimeTypeCategory.create(:name => category_name)
end
(application, audio, image, text, video, document, uncategorized) = MimeTypeCategory.all


puts "Generating MimeTypeBlacklist"
MimeType.create(:name => "DOS executable", :mime_type => "application/x-dosexec", :blacklist => true, :extension => ".com", :mime_type_category_id => application.id)

puts "Generating MimeTypes"
MimeType.create(:name => "JPEG Image File Format", :mime_type => "image/jpeg", :extension => ".jpg", :mime_type_category_id => image.id)
MimeType.create(:name => "Portable Network Graphics", :mime_type => "image/png", :extension => ".png", :mime_type_category_id => image.id)
MimeType.create(:name => "Graphics Interchange Format", :mime_type => "image/gif", :extension => ".gif", :mime_type_category_id => image.id)
MimeType.create(:name => "Tagged Image File Format", :mime_type => "image/tiff", :extension => ".tif", :mime_type_category_id => image.id)
MimeType.create(:name => "Scalable Vector Graphics", :mime_type => "image/svg+xml", :extension => ".svg", :mime_type_category_id => image.id)
MimeType.create(:name => "Windows Bitmap", :mime_type => "image/bmp", :extension => ".bmp", :mime_type_category_id => image.id)
MimeType.create(:name => "Photoshop", :mime_type => "image/vnd.adobe.photoshop", :extension => ".psd", :mime_type_category_id => image.id)

MimeType.create(:extension => ".ivf", :name => "AVI", :mime_type => "video/avi", :mime_type_category_id => video.id)
MimeType.create(:extension => ".mpg", :name => "MPEG", :mime_type => "video/mpeg", :mime_type_category_id => video.id)
MimeType.create(:extension => ".mpeg", :name => "MPEG", :mime_type => "video/mpeg", :mime_type_category_id => video.id)
MimeType.create(:extension => ".m1v", :name => "MPEG", :mime_type => "video/mpeg", :mime_type_category_id => video.id)
MimeType.create(:extension => ".mpe", :name => "MPEG", :mime_type => "video/mpeg", :mime_type_category_id => video.id)
MimeType.create(:extension => ".wmv", :name => "WMV", :mime_type => "video/x-ms-wmv", :mime_type_category_id => video.id)
MimeType.create(:extension => ".flv", :name => "Flash Video", :mime_type => "video/x-flv", :mime_type_category_id => video.id)
MimeType.create(:extension => ".avi", :name => "AVI", :mime_type => "video/avi", :mime_type_category_id => video.id)
MimeType.create(:extension => ".m4v", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category_id => video.id)
MimeType.create(:extension => ".3g2", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category_id => video.id)
MimeType.create(:extension => ".3gp", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category_id => video.id)
MimeType.create(:extension => ".mp4", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category_id => video.id)
MimeType.create(:extension => ".mov", :name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category_id => video.id)
MimeType.create(:extension => ".m2v", :name => "MPEG", :mime_type => "video/mpeg", :mime_type_category_id => video.id)

MimeType.create(:name => "MPEG-4 Audio", :mime_type => "audio/mp4", :extension => ".m4a", :mime_type_category_id => audio.id)
MimeType.create(:name => "Waveform Audio", :mime_type => "audio/x-wave", :extension => ".wav", :mime_type_category_id => audio.id)
MimeType.create(:name => "NeXt Sound File", :mime_type => "application/octet-stream", :extension => ".snd", :mime_type_category_id => audio.id)
MimeType.create(:name => "Unix Sound File", :mime_type => "audio/basic", :extension => ".au", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".aifc", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".aif", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".aiff", :name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category_id => audio.id)
MimeType.create(:name => "RIFF", :mime_type => "application/octet-stream", :extension => ".rmi", :mime_type_category_id => audio.id)
MimeType.create(:name => "MIDI Audio", :mime_type => "audio/midi", :extension => ".mid", :mime_type_category_id => audio.id)
MimeType.create(:name => "Midi", :mime_type => "audio/unkown", :extension => ".midi", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".mpa", :name => "MPEG 1/2 Audio Layer 3", :mime_type => "audio/mpeg", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".mp3", :name => "MPEG 1/2 Audio Layer 3", :mime_type => "audio/mpeg", :mime_type_category_id => audio.id)
MimeType.create(:extension => ".wma", :name => "WMA", :mime_type => "audio/x-ms-wma", :mime_type_category_id => audio.id)

MimeType.create(:name => "Comma seperated values", :mime_type => "text/plain", :extension => ".csv", :mime_type_category_id => text.id)
MimeType.create(:name => "Extensible Markup Language", :mime_type => "text/xml", :extension => ".xml", :mime_type_category_id => text.id)
MimeType.create(:name => "Plain text", :mime_type => "text/plain", :extension => ".txt", :mime_type_category_id => text.id)
MimeType.create(:name => "Rich text format", :mime_type => "text/plain", :extension => ".rtf", :mime_type_category_id => text.id)
MimeType.create(:name => "Hypertext Markup Language", :mime_type => "text/html", :extension => ".html", :mime_type_category_id => text.id)

MimeType.create(:name => "Portable Document Format", :mime_type => "application/pdf", :extension => ".pdf", :mime_type_category_id => document.id)
MimeType.create(:name => "Word X", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".docx", :mime_type_category_id => document.id)
MimeType.create(:name => "Excel X", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".xlsx", :mime_type_category_id => document.id)
MimeType.create(:name => "Word", :mime_type => "application/msword", :extension => ".doc", :mime_type_category_id => document.id)
MimeType.create(:name => "Excel", :mime_type => "application/vnd.ms-excel", :extension => ".xls", :mime_type_category_id => document.id)
MimeType.create(:name => "Powerpoint", :mime_type => "application/vnd.ms-powerpoint", :extension => ".ppt", :mime_type_category_id => document.id)
MimeType.create(:name => "Powerpoint X", :mime_type => "vnd.oasis.opendocument.text", :extension => ".pptx", :mime_type_category_id => document.id)

MimeType.create(:name => "RAR Format", :mime_type => "application/x-rar-compressed", :extension => ".rar", :mime_type_category_id => application.id)
MimeType.create(:name => "Zip Format", :mime_type => "application/zip", :extension => ".zip", :mime_type_category_id => application.id)

#special case of a non-text file with no file extension
MimeType.create(:name => "Unknown Binary", :mime_type => "application/octet-stream", :extension => "", :mime_type_category_id => application.id)

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

#Roles are needed before users because
#user role is automatically added to
#new users
puts "Generating roles"
Role.create([{ :name => "admin" },
  { :name => "steward" },
  { :name => "records_manager" },
  { :name => "user" }])
(role_admin, role_steward, role_records_manager, role_user) = Role.all

puts "Generating users"
User.create([{ :email => 'steph@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Steph' },
             {:email => 'bgadoury@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Phunk' },
             {:email => 'etann@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Evan' },
             {:email => 'admin@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Admin' },
             {:email => 'brianb@endpoint.com', :password => 'berkman', :password_confirmation => 'berkman', :name => 'Brian' },
             {:email => "user@endpoint.com", :password => "berkman", :password_confirmation => "berkman", :name => "User"}])
(user_steph, user_bgadoury, user_etann, user_admin, user_brianb, user_user) = User.all

puts "Generating groups"
Group.create([{ :name => "End Point" },
              { :name => "Test 1" },
              { :name => "Test 2" },
              { :name => "Test 3" }])
(g1, g2, g3, g4) = Group.all

g1.users << User.all
g1.owners = [user_steph, user_brianb]
g2.users = [user_steph, user_bgadoury, user_brianb, user_user]
g2.owners = [user_steph, user_brianb]
g3.users = [user_steph, user_bgadoury]
g3.owners << user_steph
g4.users = [user_steph, user_bgadoury]
g4.owners << user_steph

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

# User role is automatically assigned to all users
user_steph.roles << role_admin
user_bgadoury.roles << role_admin
user_admin.roles << role_admin
user_brianb.roles << role_admin

puts "Generating licenses"
License.create([{ :name => 'All Rights Reserved' },
        { :name => 'Public Domain' },
        { :name => 'CC BY' }])
