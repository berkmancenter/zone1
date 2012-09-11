class SftpUser < ActiveRecord::Base
  require 'digest/sha1'
  require 'fileutils'

  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :homedir

  attr_accessible :user_id
  attr_reader :raw_password

  before_validation :set_homedir, :if => "self.homedir.nil?"
  after_destroy :delete_homedir

  def uploaded_files
    # if homedir exists, but we don't have full access to it (possibly due to
    # a filesystem permissions problem in a parent directory, complain about it
    if File.directory?(self.homedir) && !( File.readable?(self.homedir) && File.executable?(self.homedir) )
      ::Rails.logger.warn "Warning: homedir exists but is not accessible (+rx) to this user"
    end
    Dir[self.homedir + "/**/*"].reject {|fn| File.directory?(fn) }
  end

  def uploaded_files?
    self.uploaded_files.any?
  end

  def sftp_url
    server_name = Preference.cached_find_by_name('sftp_server_name') || 'no_sftp_server_name_configured'
    self.username + '@' + server_name
  end

  def hash_password(password)
    "{sha1}" + Base64.strict_encode64(Digest::SHA1.digest(password))
  end


  private

  def initialize(*args)
    super(*args)
    self.username = generate_username
    @raw_password = generate_password
    # proftpd requires that the attribute be named passwd instead of password. :/
    self.passwd = hash_password(@raw_password)
    set_homedir 
  end

  def set_homedir
    return if self.user_id.nil?
    root_dir = Preference.cached_find_by_name('sftp_user_home_directory_root')
    raise "No sftp_user_home_directory_root preference found" if root_dir.nil?
    self.homedir ||= File.join(root_dir, self.user_id.to_s, self.username) 
  end

  def generate_username
    'user' + SecureRandom.hex(4).upcase
  end

  def generate_password
    SecureRandom.hex(8).downcase
  end

  def delete_homedir
    FileUtils.rm_rf(self.homedir) if File.directory?(self.homedir)
  end

end
