require 'spec_helper'

describe License do
  it { should belong_to(:stored_file) }
end
