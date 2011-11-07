class SftpGroup < ActiveRecord::Base
  has_many :sftp_users
end
