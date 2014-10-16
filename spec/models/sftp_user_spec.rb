require "spec_helper"

describe SftpUser do

  before do
    FactoryGirl.create :sftp_user_home_directory_root
    @sftp_user = FactoryGirl.create :sftp_user
  end
  
  it { @sftp_user.should validate_presence_of :user_id }
  it { @sftp_user.should belong_to :user }
  it { @sftp_user.should allow_mass_assignment_of :user_id }

  describe "hash_password" do
    it "should create password string in format accepted by ProFTPD" do
      @sftp_user.hash_password('abc123lol').should == "{sha1}qT8+4YJfHZOwcLK7VX8ylk2rgro="
    end
  end

end
