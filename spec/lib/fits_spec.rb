require "spec_helper"

describe "Fits" do
  describe ".analyze(file_url)" do

    let(:file_url) { __FILE__.to_s }  #have FITS analyze this spec by default

    context "when the file_url does not exist" do
      before do
        Fits.should_receive(:test).with(?f, file_url).and_return(false)
      end
      it "should raise an error" do
        assert_raise RuntimeError do
          Fits.analyze(file_url)
        end
      end    
    end

    context "when FITs is unable to read the file" do
      before do
        Fits.should_receive(:open).with("|/usr/local/bin/fits/fits.sh -i #{file_url}").and_return('')
      end
      it "should raise an error" do
        assert_raise RuntimeError do
          Fits.analyze(file_url)
        end
      end
    end

    context "when FITs is able to read the file" do

      before :all do
        @results = Fits.analyze(file_url)
      end

      it "should return a hash" do
        assert @results.is_a?(Hash)
      end

      it "should return a hash with fits_mime_type as a key" do
        assert @results.has_key?(:fits_mime_type)
      end

      it "should return a hash with a key fits_mime_type with a value which is a hash" do
        assert @results[:fits_mime_type].is_a?(Hash)
      end

      it "should return a hash with a key fits_mime_type with a value which is a hash and has a key of format_name" do
        assert @results[:fits_mime_type].has_key?(:format_name)
      end

      it "should return a hash with a key fits_mime_type with a value which is a hash and has a key of mime_type" do
        assert @results[:fits_mime_type].has_key?(:mime_type)
      end

      it "should return a hash with a key format_version"

      it "should return a hash with a key file_size" do
        assert @results.has_key?(:file_size)
      end

      it "should return a hash with a key md5" do
        assert @results.has_key?(:md5)
      end
    end

  end
end
