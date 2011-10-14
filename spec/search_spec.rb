require 'spec_helper'
require 'support/sunspot'

describe 'Search' do
	before(:each) do
		@sf = StoredFile.create!(:original_file_name => "abx99", :user_id => 4, :access_level_id => 1, :content_type_id => 1)
	end

	it "should find a file" do
    	Sunspot.search(StoredFile) { keywords 'xab' }.first.should == @sf
  end
	
end
