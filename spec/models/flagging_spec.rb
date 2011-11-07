require 'spec_helper'

describe Flagging do
  it { should belong_to :flag }
  it { should belong_to :stored_file }

  it { should validate_presence_of :flag_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :stored_file_id }
end
