require "spec_helper"

describe Dash do

  it "REPO_NAME is correct" do
    Dash::REPO_NAME.should == 'dash'
  end
  
    before(:each) do
      @user = FactoryGirl.create :user
      @user_id = @user.id
      @stored_file1 = FactoryGirl.create :stored_file
      @stored_file2 = FactoryGirl.create :stored_file
      @stored_files = [@stored_file1, @stored_file2]
      @stored_file_ids = @stored_files.map(&:id)
      @username = 'user1'
      @password = 'pass1'
      @collection = 'collection_name'
      @expected_arg_error = /missing required param/i
      @params = {
        'stored_file_ids' => @stored_file_ids,
        'user_id' => @user_id,
        'username' => @username,
        'password' => @password,
        'collection' => @collection,
      }
    end

  describe ".export_to_repo(params)" do

    

    it "should raise an error when called with any missing params" do
      expect {
        Dash.export_to_repo()
      }.to raise_error ArgumentError, @expected_arg_error
    end

    context "when passed valid params" do

      after(:each) do
        Dash.export_to_repo(@params)
      end

      it "should get stored_file(s) and User with appropriate params" do
        Dash::Package.stub(:new) { mock('pkg', :destroy => nil) }
        Dash::Communicator.any_instance.stub(:export_to_repo)
        Dash.stub(:process_export_results)
        User.should_receive(:find).with(@user_id)
        StoredFile.should_receive(:find).with(@stored_file_ids).and_return(@stored_files)
      end

      it "should call Dash::* with appropriate plumbing" do
        export_package_stub = mock('export_package', :destroy => nil)
        export_receipt_stub = stub 'export_receipt'

        Dash::Package.should_receive(:new).exactly(2).times { export_package_stub }
        Dash::Communicator.any_instance.should_receive(:export_to_repo).exactly(2).times.with(export_package_stub, @collection) { export_receipt_stub }
        Dash.should_receive(:process_export_results)
          .with(@user,
                @params,
                [{:stored_file => @stored_file1}, {:stored_file => @stored_file2}]);
      end
      
    end
  end

  describe "email .process_export_results(user, export_receipt)" do

    it "should call UserMailer method with correct plumbing" do
#      user = stub 'user'
#      export_receipts = stub 'export_receipts'
      user_mailer_stub = mock(:deliver)
      export_results = [{:stored_file => @stored_file1}, {:stored_file => @stored_file2}]
      UserMailer.should_receive(:export_to_repo_confirmation).with(@user, export_results) { user_mailer_stub }
      user_mailer_stub.should_receive(:deliver)
      Dash.process_export_results(@user, @params, export_results)
    end
=begin
    # TODO: This should be in the UserMailer spec really
    before do
      @user = FactoryGirl.create :user
    end

    before(:each) do
      ActionMailer::Base.deliveries = []
    end

    #TODO: stub UserMailer.export_to_repo_confirmation and only test for should_receive...with
    it "should email the user" do
      Dash.process_export_results(@user, 'export_receipt')
      ActionMailer::Base.deliveries.last.to.should == [@user.email]
    end

    it "should test something to prove an email template was used" do
      Dash.process_export_results(@user, 'export_receipt')
      ActionMailer::Base.deliveries.last.to.should == [@user.email]
    end
=end
  end
end
