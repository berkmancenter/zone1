require "spec_helper"

describe Dash::Communicator do

  describe "export_to_repo" do
    before(:each) do
      @communicator = Dash::Communicator.new('user1', 'pass1')
      @collection_name = 'some collection'
      @export_package = mock('export_package', :path => stub)
    end

    it "should pass collection_name through get_collection" do
      collection_stub = mock('collection', :post_media! => nil)
      @communicator.should_receive(:get_collection).with(@collection_name) { collection_stub }
      @communicator.export_to_repo(@export_package, @collection_name)
    end
    
    it "should pass collection_name through get_collection" do
      collection_stub = mock('collection', :post_media! => nil)
      @communicator.should_receive(:get_collection).with(@collection_name) { collection_stub }
      @communicator.export_to_repo(@export_package, @collection_name)
    end
    
    it "should pass correct content_type and packaging params to post_media!" do
      collection_stub = mock('collection', :post_media! => nil)
      @communicator.stub(:get_collection) { collection_stub }
      collection_stub.should_receive(:post_media!).with(
                                                        :filepath => @export_package.path,
                                                        :content_type => 'application/zip',
                                                        :packaging => 'http://purl.org/net/sword-types/METSDSpaceSIP'
                                                        )
      @communicator.export_to_repo(@export_package, collection_stub)
    end

  end

  describe "get_collection" do
    before(:each) do
      @mock_col_nameone = mock('name1', :title => 'nameOne')
      @mock_col_nametwo = mock('name2', :title => 'nameTwo')
      @communicator = Dash::Communicator.new('user1', 'pass1')
      @communicator.stub(:collections) { [@mock_col_nameone, @mock_col_nametwo] }
    end
    
    it "should find a collection instance by title" do
      @communicator.get_collection('nameTwo').should == @mock_col_nametwo
    end
    
    it "should return nil if it cannot find a collection instance by title" do
      @communicator.get_collection('Not a real collection name').should == nil
    end
  end

end
