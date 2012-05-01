class SftpUser < ActiveRecord::Base
  require 'digest/sha1'
  require 'base64'
  require 'fileutils'

  belongs_to :user

  validates_presence_of :user_id

  after_destroy :delete_homedir

  attr_accessible :user_id, :homedir
  attr_reader :raw_password

  def uploaded_files
    # if homedir exists, but we don't have full access to it (possibly due to
    # a filesystem permissions problem in a parent directory, complain about it
    if File.directory?(self.homedir) && !( File.readable?(self.homedir) && File.executable?(self.homedir) )
      ::Rails.logger.warn "Warning: homedir exists but is not accessible (+rx) to this user"
    end
    Dir[self.homedir + "/**/*"].reject {|fn| File.directory?(fn) }
  end

  def uploaded_files?
    self.uploaded_files.size > 0
  end

  def sftp_url
    server_name = Preference.sftp_server_name || 'no_sftp_server_name_configured'
    self.username + '@' + server_name
  end

  private

  def initialize(params = nil)
    super

    self.username = generate_username
    @raw_password = generate_password
    # proftpd requires that the attribute be named passwd instead of password. :/
    self.passwd = hash_password(@raw_password)
    self.homedir = generate_homedir
  end

  def delete_homedir
    FileUtils.rm_rf(self.homedir) if File.directory?(self.homedir)
  end

  def generate_username
    'user' + SecureRandom.hex(4).upcase
  end

  def generate_password
    SecureRandom.hex(8).downcase
  end

  def hash_password(password)
    "{sha1}" + Base64.encode64s(Digest::SHA1.digest(password))
  end

  def generate_homedir
    File.join(Preference.sftp_user_home_directory_root, self.user_id.to_s, self.username)
  end

end
