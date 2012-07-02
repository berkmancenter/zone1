require "spec_helper"

describe "Package" do

  describe "new" do

    it "should make call to metadata and zipfile" do
      stored_file = stub
      metadata = stub
      metadata_file = stub
      Dash::Translator.should_receive(:build_metadata).with(stored_file) { metadata }
      Dash::Package.any_instance.should_receive(:create_metadata_file).with(metadata) { metadata_file }
      Dash::Package.any_instance.should_receive(:create_zipfile).with(stored_file, metadata_file)

      Dash::Package.new(stored_file)
    end

    it "should raise an exception if metadata is nil" do
      stored_file = stub
      metadata = stub
      Dash::Translator.stub(:build_metadata).with(stored_file) { metadata }
      Dash::Package.any_instance.should_receive(:create_metadata_file).with(metadata) { nil }

      expect {
        Dash::Package.new(stored_file)
      }.to raise_error Exception, /returned nil/
    end

  end

  describe "instance methods" do
    before(:each) do
      @stored_file = stub
      @metadata = "some metadata"
      @metadata_file = 'somefile.zip'
      Dash::Translator.stub(:build_metadata) { @metadata }
    end 

    it "create_metadata_file() should create a metadata file" do
      Dash::Package.any_instance.stub(:create_zipfile)
      package = Dash::Package.new(@stored_file)
      path = package.send(:create_metadata_file, @metadata)

      File.exist?(path).should == true
      File.open(path) {|file| file.read}.should == @metadata
    end

    it "create_zipfile() should create the package zipfile under Rails.root/tmp" do
      @stored_file = FactoryGirl.create :stored_file
      Dash::Package.any_instance.stub(:create_metadata_file) { stub }
      Zip::ZipFile.should_receive(:open)
      File.stub(:unlink)
      package = Dash::Package.new(@stored_file)

      expected_export_dir = File.join(Rails.root, 'tmp', 'exports', Dash::REPO_NAME)
      package.should respond_to(:path)
      package.path.should =~ /^#{expected_export_dir}/
    end

    describe "destroy" do
      it "should unlink @path" do
        @stored_file = FactoryGirl.create :stored_file
        metadata_file = stub 'metadata_file'
        Dash::Package.any_instance.stub(:create_metadata_file) { metadata_file }
        path_stub = stub 'path'
        Dash::Package.any_instance.stub(:create_zipfile) { path_stub }
        File.should_receive(:unlink).with(path_stub)
        package = Dash::Package.new(@stored_file)
        package.destroy
      end
    end
    
  end

end
