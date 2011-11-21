class SftpUser < ActiveRecord::Base
  require 'digest/sha1'
  require 'base64'
  require 'fileutils'

  belongs_to :user
  validates_presence_of :user_id
  after_destroy :delete_homedir
  attr_accessible :user_id, :homedir
  attr_reader :raw_password

  HOMEDIR_ROOT = '/home/sftp/uploads'

  def uploaded_files
    Dir[self.homedir + "/**/*"].reject {|fn| File.directory?(fn) }
  end

  def uploaded_files?
    self.uploaded_files.size > 0
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
    FileUtils.rm_rf self.homedir if test(?d, self.homedir)
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
    if [self.user_id, self.username].any? {|a| a.nil?}
      raise Exception.new("Cannot generate_homedir without both user_id and username")
    end
    HOMEDIR_ROOT + '/' + self.user_id.to_s + '/' + self.username
  end

end
