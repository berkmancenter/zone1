require "spec_helper"

describe SftpUser do

  before do
    FactoryGirl.create :sftp_user_home_directory_root
    @sftp_user = FactoryGirl.create :sftp_user
  end
  
  it { @sftp_user.should validate_presence_of :user_id }
  it { @sftp_user.should belong_to :user }
  it { @sftp_user.should allow_mass_assignment_of :user_id }

end
