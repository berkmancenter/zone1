class CreateSftpUserHomeDirPreference < ActiveRecord::Migration
  def up
    Preference.create :name => "sftp_user_home_directory_root", :label => "SFTP User Home Directory Root (Absolute Path)", :value => "/home/sftp/uploads"
  end

  def down
    Preference.find_by_name("sftp_user_home_directory_root").destroy
  end
end
