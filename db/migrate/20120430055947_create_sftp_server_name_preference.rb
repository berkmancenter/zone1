class CreateSftpServerNamePreference < ActiveRecord::Migration
  def up
    Preference.create :name => "sftp_server_name", :label => "SFTP Full Hostname or IP address", :value => ""
  end

  def down
    Preference.find_by_name("sftp_server_name").destroy
  end
end
