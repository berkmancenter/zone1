require 'spec_helper'

describe SftpGroup do
  it { should have_many :sftp_users }
end
