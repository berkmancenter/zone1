require 'spec_helper'

describe RightAssignment do
  it { should belong_to(:right) }
  it { should belong_to(:subject) }
end
