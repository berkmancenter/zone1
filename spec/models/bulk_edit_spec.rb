require "spec_helper"

describe BulkEdit do
  describe ".bulk_editable_attributes" do

    it "should take the union of the output from attr_accessible_for for each stored file" do
      
      stored_file_1 = double "StoredFile"
      stored_file_2 = double "StoredFile"
      stored_file_1.stub(:attr_accessible_for).and_return(["attr1", "attr3"])
      stored_file_2.stub(:attr_accessible_for).and_return(["attr1", "attr2"])

      stored_files = [stored_file_1, stored_file_2]
      user = double "User"

      BulkEdit.bulk_editable_attributes(stored_files, user).should == ["attr1"]
    end
  end

  describe ".matching_attributes_from" do


    context "when attributes are matching" do

      it "should return hash of attributes with values" do
        attributes_to_match = StoredFile.new.attribute_names + %w(tag_list collection_list)
        stored_file_1 = double("stored_file")
        stored_file_2 = double("stored_file")
        stored_file_3 = double("stored_file")
        stored_files = [stored_file_1, stored_file_2, stored_file_3]
        
        expected_hash = {}
        
        attributes_to_match.each do |attribute|
          stored_file_1.stub(attribute).and_return("matching")
          stored_file_2.stub(attribute).and_return("matching")
          stored_file_3.stub(attribute).and_return("matching")
          expected_hash.merge!({attribute => "matching"})
        end

        BulkEdit.matching_attributes_from(stored_files).should == expected_hash
      end
    end

    context "when attributes are not matching" do
      it "should return a hash with empty values" do

        attributes_to_match = StoredFile.new.attribute_names + %w(tag_list collection_list)
        stored_file_1 = double("stored_file")
        stored_file_2 = double("stored_file")
        stored_file_3 = double("stored_file")
        stored_files = [stored_file_1, stored_file_2, stored_file_3]
        
        expected_hash = {}
        
        attributes_to_match.each do |attribute|
          stored_file_1.stub(attribute).and_return(SecureRandom.hex(8))
          stored_file_2.stub(attribute).and_return(SecureRandom.hex(8))
          stored_file_3.stub(attribute).and_return(SecureRandom.hex(8))
          expected_hash.merge!({attribute => ""})
        end

        BulkEdit.matching_attributes_from(stored_files).should == expected_hash
      end
    end
  end

  describe ".matching_flags_from" do
    
    it "should take the union of the output from flags for each stored file" do
      
      stored_file_1 = double "StoredFile"
      stored_file_2 = double "StoredFile"
      stored_file_1.stub(:flags).and_return(["flag1", "flag3"])
      stored_file_2.stub(:flags).and_return(["flag1", "flag2"])

      stored_files = [stored_file_1, stored_file_2]

      BulkEdit.matching_flags_from(stored_files).should == ["flag1"]
    end
  end
  
  describe ".matching_groups_from" do
    
    it "should take the union of the output from groups for each stored file" do
      
      stored_file_1 = double "StoredFile"
      stored_file_2 = double "StoredFile"
      stored_file_1.stub(:groups).and_return(["group1", "group3"])
      stored_file_2.stub(:groups).and_return(["group1", "group2"])

      stored_files = [stored_file_1, stored_file_2]

      BulkEdit.matching_groups_from(stored_files).should == ["group1"]
    end
  end
end
