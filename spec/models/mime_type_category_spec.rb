require 'spec_helper'

describe MimeTypeCategory do
  it { should have_many :mime_types }
  it { should have_many :stored_files }
end
