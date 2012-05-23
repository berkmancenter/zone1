require 'spec_helper'

describe MimeTypeCategory do
  it { should have_many :mime_types }
  it { should have_many :stored_files }

  it { should validate_presence_of(:name) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:icon) }

  pending "should return array of MimeTypeCategory objects from cached self.all method"

  describe "default MimeTypeCategory" do
    let(:mime_type_category) { FactoryGirl.create(:mime_type_category, :name => "Uncategorized") }
    it "should use name = 'Uncategorized' for self.default MimeTypeCategory" do
      mime_type_category.name.should == "Uncategorized"
    end

    it "should return 'Uncategorized' MimeTypeCategory from default method" do
      mime_type_category.should == MimeTypeCategory.default
    end
      
  end

  describe "callbacks" do

    before do
      @mime_type_category = MimeTypeCategory.new :name => "test"
    end

    context "after_create" do
      
      before do
        @mime_type_category.should_receive(:destroy_cache)
      end

      it "should destroy_cache" do
        @mime_type_category.save
      end
    end


    context "after_update" do

      before do 
        @mime_type_category.should_receive(:destroy_cache)
      end

      it "should destroy_cache" do
        @mime_type_category.update_attributes(:name => "New Name")
      end

    end


    context "after_destroy" do
      
      before do
        @mime_type_category.should_receive(:destroy_cache)
      end
      
      it "should destroy_cache" do
        @mime_type_category.destroy
      end
    end
  end #describe callbacks


end
