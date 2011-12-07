require 'spec_helper'

describe MimeType do
  it { should have_many(:stored_files) }
  it { should belong_to(:mime_type_category) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:mime_type) }
  it { should validate_presence_of(:extension) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:mime_type) }
  it { should allow_mass_assignment_of(:extension) }
  it { should allow_mass_assignment_of(:blacklist) }
  it { should allow_mass_assignment_of(:mime_type_category_id) }

  describe "before_create" do

    describe "downcase_extension" do
      let(:mime_type) { Factory(:mime_type, :extension => ".JPG") }
      it "should downcase the extension" do
        mime_type.extension.should == ".jpg"
      end
    end

    describe "set default category" do
      it "sets the MimeTypeCategorty to 'Uncategorized'" do
        subject { Factory(:mime_type) }
        subject.mime_type_category.should == MimeTypeCategory.find_by_name("Uncategorized")
      end
    end
  end

  describe "destroy_blacklisted_extensions_cache" do
    let(:mime_type) { Factory(:mime_type) }

    before do
      MimeType.blacklisted_extensions
      assert Rails.cache.exist?("file_extension_blacklist")
    end

    after do
      assert !Rails.cache.exist?("file_extension_blacklist")
    end

    it "should be destroyed after_update" do
      mime_type.update_attribute(:name, "asdf")
    end

    it "should be destroyed after_create" do
      Factory(:mime_type)
    end

    it "should be destroyed after_destroyed" do
      mime_type.destroy
    end
  end

  describe ".blacklisted_extensions" do
    it "should return an array of extensions marked as blacklisted" do
      Factory(:mime_type, :blacklist => true, :extension => ".exe")
      Factory(:mime_type, :blacklist => false, :extension => ".jpg")
      MimeType.blacklisted_extensions.should == [".exe"]
    end
  end

  describe ".file_extension_blacklisted?(filename)" do
    context "when the extension is blacklisted" do
      before do
        MimeType.should_receive(:blacklisted_extensions).and_return([".exe"])
      end
      it "should return true " do
        assert MimeType.file_extension_blacklisted?("virus.exe")
      end
    end

    context "when the extension is not blacklisted" do
      before do
        MimeType.should_receive(:blacklisted_extensions).and_return([])
      end
      it "should call backlisted_extensions" do
        assert !MimeType.file_extension_blacklisted?("virus.exe")
      end
    end
  end
end
