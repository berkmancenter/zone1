require 'spec_helper'

describe Right do
  it { should validate_presence_of :action }
  it { should have_many :right_assignments }
end
