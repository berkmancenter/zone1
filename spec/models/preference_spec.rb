require 'spec_helper'

describe Preference do
  it { should validate_presence_of :name }
  it { should validate_presence_of :value }
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :value }
end
