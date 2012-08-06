require 'spec_helper'

describe MimeType do
  it { should have_many(:stored_files) }
  it { should belong_to(:mime_type_category) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:mime_type) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:mime_type) }
  it { should allow_mass_assignment_of(:extension) }
  it { should allow_mass_assignment_of(:blacklist) }
  it { should allow_mass_assignment_of(:mime_type_category_id) }

  describe "before_create" do

    describe "downcase_extension" do
      let(:mime_type) { FactoryGirl.create(:mime_type, :extension => ".JPG") }
      it "should downcase the extension" do
        mime_type.extension.should == ".jpg"
      end
    end

    describe "set default category" do
      it "auto-detects the MimeTypeCategory" do
        subject { FactoryGirl.create(:mime_type, :mime_type => "application/test") }
        subject.mime_type_category.should == MimeTypeCategory.find_by_name("Application")
      end

      it "sets the MimeTypeCategory to 'Uncategorized' if not auto-detected" do
        subject { FactoryGirl.create(:mime_type) }
        subject.mime_type_category.should == MimeTypeCategory.default
      end
    end
  end

  describe "new_from_attributes" do
    it "should handle empty file extension"
    it "should return a MimeType MT instance"
    it "should not save new MimeType instance"
  end

  describe "blacklist and mime_types caches" do
    let(:mime_type) { FactoryGirl.create(:mime_type) }

    before do
      MimeType.blacklisted_extensions
      MimeType.all
      assert Rails.cache.exist?("extension_blacklist")
      assert Rails.cache.exist?("mime_types")
    end

    after do
      assert !Rails.cache.exist?("extension_blacklist")
      assert !Rails.cache.exist?("mime_types")
    end

    it "should be destroyed after_update" do
      mime_type.update_attribute(:name, "asdf")
    end

    it "should be destroyed after_create" do
      FactoryGirl.create(:mime_type)
    end

    it "should be destroyed after_destroyed" do
      mime_type.destroy
    end
  end

  describe ".blacklisted_extensions" do
    it "should return an array of extensions marked as blacklisted" do
      FactoryGirl.create(:mime_type, :blacklist => true, :extension => ".exe")
      FactoryGirl.create(:mime_type, :blacklist => false, :extension => ".jpg")
      MimeType.blacklisted_extensions.should == [".exe"]
    end
  end

  describe ".extension_blacklisted?(filename)" do
    context "when the extension is blacklisted" do
      before do
        MimeType.should_receive(:blacklisted_extensions).and_return([".exe"])
      end
      it "should return true " do
        assert MimeType.extension_blacklisted?("virus.exe")
      end
    end

    context "when the extension is not blacklisted" do
      before do
        MimeType.should_receive(:blacklisted_extensions).and_return([".exe"])
      end
      it "should return false" do
        assert !MimeType.extension_blacklisted?("file.jpg")
      end
    end

    context "when the extension is empty" do
      before do
        MimeType.should_receive(:blacklisted_extensions).and_return([".exe"])
      end
      it "should return false" do
        assert !MimeType.extension_blacklisted?("file")
      end
    end
  end
end
