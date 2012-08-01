require "spec_helper"

describe Dash::Translator do

  describe "self.build_metadata" do

    before do
      @stored_file = FactoryGirl.create :stored_file
    end

    it "should raise exception for nil stored_file param" do
      expect {
        Dash::Translator.build_metadata(nil)
      }.to raise_error ArgumentError, /nil stored_file/
    end

    it "should call ActionController::Base.new.render_to_string correctly and return the result" do
      @rendered_xml = stub
      ActionController::Base.any_instance.should_receive(:render_to_string).with(
        'stored_files/export_to_repo/_package.mets',
        :locals => {:stored_file => @stored_file}
      ).and_return(@rendered_xml)

      Dash::Translator.build_metadata(@stored_file).should == @rendered_xml
    end

#    it "should call render on the child builder template with the correct params" do
#      Builder::XmlMarkup.any_instance.should_receive(:render).with(
#        'stored_files/export_to_repo/epdcx.mets',
#        {:stored_file => @stored_file}
#      )
#      Dash::Translator.build_metadata(@stored_file)
#    end

    it "should successfully render the metadata template " do
      xml_output = Dash::Translator.build_metadata(@stored_file)
      xml_output.should_not == nil
      xml = Nokogiri::XML(xml_output)
    end

  end

end

