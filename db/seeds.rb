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
ContentType.delete_all
Role.delete_all
Right.delete_all
Disposition.delete_all
Preference.delete_all
DispositionAction.delete_all

connection = ActiveRecord::Base.connection
connection.execute("DELETE FROM roles_users")

puts "Generating default preferences"
Preference.create([{:name => "Default User Upload Quota", :value => "10485760" }])
Preference.create([{:name => "Retention Period", :value => "1825" }])
Preference.create([{:name => "Max Web Upload Filesize", :value => "500kb" }])


puts "Generating default MimeTypeCategories"
#http://www.iana.org/assignments/media-types/index.html
%w(Application Audio Image Text Video Document).each do |category_name|
  MimeTypeCategory.create(:name => category_name)
end
(application, audio, image, text, video, document) = MimeTypeCategory.all



puts "Gerenating default MimeTypeBlacklist"
MimeType.create(:name => "DOS/Windows executable", :mime_type => "application/x-dosexec", :blacklist => true, :extension => ".exe", :mime_type_category => application)
MimeType.create(:name => "Mac OS X Application", :mime_type => "application/", :blacklist => true, :extension => ".app", :mime_type_category => application)
MimeType.create(:name => "DOS Batch File", :mime_type => "application/", :blacklist => true, :extension => ".bat", :mime_type_category => application)
MimeType.create(:name => "CGI", :mime_type_name => "Hypertext Markup Language", :mime_type => "text/html", :blacklist => true, :extension => ".cgi", :mime_type_category => application)
MimeType.create(:name => "DOS executable", :mime_type => "application/x-dosexec", :blacklist => true, :extension => ".com", :mime_type_category => application)
MimeType.create(:name => "Visual Basic script", :mime_type => "application/vb", :blacklist => true, :extension => ".vb", :mime_type_category => application)


puts "Generating default MimeTypes"
MimeType.create(:name => "JPEG", :mime_type_name => "Exchangeable Image File Format", :mime_type => "image/jpeg", :extension => ".jpg", :mime_type_category => image)
MimeType.create(:name => "PNG", :mime_type_name => "Portable Network Graphics", :mime_type => "image/png", :extension => ".png", :mime_type_category => image)
MimeType.create(:name => "GIF", :mime_type_name => "Graphics Interchange Format", :mime_type => "image/gif", :extension => ".gif", :mime_type_category => image)
MimeType.create(:name => "TIF", :mime_type_name => "Tagged Image File Format", :mime_type => "image/tiff", :extension => ".tif", :mime_type_category => image)
MimeType.create(:name => "SVG", :mime_type_name => "Scalable Vector Graphics", :mime_type => "image/svg+xml", :extension => ".svg", :mime_type_category => image)
MimeType.create(:name => "BMP", :mime_type_name => "Windows Bitmap", :mime_type => "image/bmp", :extension => ".bmp", :mime_type_category => image)
MimeType.create(:name => "PSD", :mime_type_name => "PSD EXIF", :mime_type => "image/vnd.adobe.photoshop", :extension => ".psd", :mime_type_category => image)

MimeType.create(:name => "IVF", :mime_type_name => "AVI", :mime_type => "video/avi", :extension => ".ivf", :mime_type_category => video)
MimeType.create(:name => "MPG", :mime_type_name => "MPEG", :mime_type => "video/mpeg", :mime_type_category => video)
MimeType.create(:name => "MPEG", :mime_type_name => "MPEG", :mime_type => "video/mpeg", :mime_type_category => video)
MimeType.create(:name => "M1V", :mime_type_name => "MPEG", :mime_type => "video/mpeg", :mime_type_category => video)
MimeType.create(:name => "MPE", :extension => ".mpe", :mime_type_name => "MPEG", :mime_type => "video/mpeg", :mime_type_category => video)
MimeType.create(:name => "WMV", :extension => ".wmv", :mime_type_name => "WMV", :mime_type => "video/x-ms-wmv", :mime_type_category => video)
MimeType.create(:name => "FLV", :extension => ".flv", :mime_type_name => "Flash Video", :mime_type => "video/x-flv", :mime_type_category => video)
MimeType.create(:name => "AVI", :extension => ".avi", :mime_type_name => "AVI", :mime_type => "video/avi", :mime_type_category => video)
MimeType.create(:name => "M4V", :extension => ".m4v", :mime_type_name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category => video)
MimeType.create(:name => "M4V", :extension => ".3g2", :mime_type_name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category => video)
MimeType.create(:name => "M4V", :extension => ".3gp", :mime_type_name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category => video)
MimeType.create(:name => "M4V", :extension => ".mp4", :mime_type_name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category => video)
MimeType.create(:name => "MOV", :extension => ".mov", :mime_type_name => "ISO Media, MPEG v4 system, version 2", :mime_type => "video/mp4", :mime_type_category => video)
MimeType.create(:name => "M2V", :extension => ".m2v", :mime_type_name => "MPEG", :mime_type => "video/mpeg", :mime_type_category => video)

MimeType.create(:name => "M4A", :mime_type_name => "MPEG-4 Audio", :mime_type => "audio/mp4", :extension => ".m4a", :mime_type_category => audio)
MimeType.create(:name => "WAV", :mime_type_name => "Waveform Audio", :mime_type => "audio/x-wave", :extension => ".wav", :mime_type_category => audio)
MimeType.create(:name => "SND", :mime_type_name => "NeXt Sound File", :mime_type => "application/octet-stream", :extension => ".snd", :mime_type_category => audio)
MimeType.create(:name => "AU", :mime_type_name => "Unix Sound File", :mime_type => "audio/basic", :extension => ".au", :mime_type_category => audio)
MimeType.create(:name => "AIFC", :mime_type_name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category => audio)
MimeType.create(:name => "AIF", :mime_type_name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category => audio)
MimeType.create(:name => "AIFF", :mime_type_name => "Audio Interchange File Format", :mime_type => "audio/x-aiff", :mime_type_category => audio)
MimeType.create(:name => "RMI", :mime_type_name => "RIFF", :mime_type => "application/octet-stream", :extension => ".rmi", :mime_type_category => audio)
MimeType.create(:name => "MID", :mime_type_name => "MIDI Audio", :mime_type => "audio/midi", :extension => ".mid", :mime_type_category => audio)
MimeType.create(:name => "MIDI", :mime_type_name => "Midi", :mime_type => "audio/unkown", :extension => ".midi", :mime_type_category => audio)
MimeType.create(:name => "MPA", :mime_type_name => "MPEG 1/2 Audio Layer 3", :mime_type => "audio/mpeg", :mime_type_category => audio)
MimeType.create(:name => "MP3", :mime_type_name => "MPEG 1/2 Audio Layer 3", :mime_Type => "audio/mpeg", :mime_type_category => audio)
MimeType.create(:name => "WMA", :extension => ".wma", :mime_type_name => "WMA", :mime_type => "audio/x-ms-wma", :mime_type_category => audio)

MimeType.create(:name => "CSV", :mime_type_name => "Comma seperated values", :mime_type => "text/plain", :extension => ".csv", :mime_type_category => text)
MimeType.create(:name => "XML", :extension => ".xml", :mime_type_name => "Extensible Markup Language", :mime_type => "text/xml", :mime_type_category => text)
MimeType.create(:name => "Plain text", :mime_type_name => "Plain text", :mime_type => "text/plain", :extension => ".txt", :mime_type_category => text)
MimeType.create(:name => "RTF", :mime_type_name => "Rich text format", :mime_type => "text/plain", :extension => ".txt", :mime_type_category => text)
MimeType.create(:name => "HTML", :mime_type_name => "Hypertext Markup Language", :mime_type => "text/html", :extension => ".html", :mime_type_category => text)

MimeType.create(:name => "PDF", :mime_type_name => "Portable Document Format", :mime_type => "application/pdf", :extension => ".pdf", :mime_type_category => document)
MimeType.create(:name => "Microsoft Word 2007 and later", :mime_type_name => "OpenDocument Text", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".docx", :mime_type_category => document)
MimeType.create(:name => "Microsoft Excel 2007 and later", :mime_type_name => "OpenDocument Text", :mime_type => "application/vnd.oasis.opendocument.text", :extension => ".xlsx", :mime_type_category => document)
MimeType.create(:name => "Microsoft Word 2003 and earlier", :mime_type_name => "DOC", :mime_type => "application/msword", :extension => ".doc", :mime_type_category => document)
MimeType.create(:name => "Microsoft Excel 2003 and earlier", :mime_type_name => "XLS", :mime_type => "application/vnd.ms-excel", :extension => ".xls", :mime_type_category => document)
MimeType.create(:name => "Microsoft Powerpoint 2003 and earlier", :mime_type_name => "PPT", :mime_type => "application/vnd.ms-powerpoint", :extension => ".ppt", :mime_type_category => document)
MimeType.create(:name => "Micosoft Powerpoint 2007 and later", :mime_type_name => "OpenDocument Text", :mime_type => "vnd.oasis.opendocument.text", :extension => ".pptx", :mime_type_category => document)

MimeType.create(:name => "RAR", :mime_type_name => "RAR Format", :mime_type => "application/x-rar-compressed", :extension => ".rar", :mime_type_category => application)
MimeType.create(:name => "ZIP", :mime_type => "application/zip", :extension => ".zip", :mime_type_category => application)

puts "Creating disposition actions"
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

puts "Generating content type"
ContentType.create([{ :name => "image" }, { :name => "doc" }])
(c1, c2) = ContentType.all

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

puts "Generating roles"
Role.create([{ :name => "admin" },
  { :name => "steward" },
  { :name => "records_manager" },
  { :name => "user" }])
(role_admin, role_steward, role_records_manager, role_user) = Role.all

role_admin.rights = Right.all
role_admin.save
role_steward.rights = [ri1, ri2, ri3, ri17, ri27, ri28, ri29] # preservation flags, view preserved flag content
role_steward.save
role_records_manager.rights = [ri4, ri5, ri6, ri8, ri10, ri12, ri15, ri30, ri31] #university flags, accessibility, view any content, manage_dispositions
role_records_manager.save
role_user.rights = [ri2, ri5, ri9, ri11, ri14, ri16, ri19, ri21, ri23, ri25] #nominate preservation flag, partially open and dark settings, view own content, manage own comments 
role_user.save

# Assign user role to all users
user_steph.roles << [role_admin, role_user]
user_bgadoury.roles << role_user
user_etann.roles << role_user
user_admin.roles << [role_admin, role_user]
user_brianb.roles << [role_admin, role_user]
user_user.roles << [role_user]

puts "Generating licenses"
License.create([{ :name => 'All Rights Reserved' },
        { :name => 'Public Domain' },
        { :name => 'CC BY' }])
