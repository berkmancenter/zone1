require "spec_helper"

describe "Fits" do

  describe ".analyze(file_url)" do

    #have FITS analyze this spec by default
    let(:file_url) { __FILE__.to_s }
    
    context "when the file_url does not exist" do
      it "should raise an error" do
        expect {
          Fits.get_fits_output(file_url + " -1 @&@#$@$#")
        }.to raise_error /File not found/i
      end    
    end

    context "when Fits can't get the fits_script_path Preference" do
      before do
        Preference.stub(:cached_find_by_name) { }
      end
      it "should raise an error" do
        expect {
          Fits.get_fits_output(file_url)
        }.to raise_error /No fits_script_path preference value found/i
      end
    end

    context "when the fits_script_path Preference is is bogus " do
      context "because its not executable" do
        before do
          File.stub(:executable?).and_return(false)
        end

        it "should raise an error" do
          expect {
            Fits.validate_fits_script_path('/dev/null/fits.sh')
          }.to raise_error /Invalid fits_script_path preference value/i
        end
      end

      context "because it doesn't end in fits.sh" do
        before do
          File.stub(:executable?).and_return(true)
        end
        it "should raise an error" do
          expect {
            Fits.validate_fits_script_path('/dev/null/fits.sh;hackedlol.sh')
          }.to raise_error /Invalid fits_script_path preference value/i
        end
      end
    end

    context "when FITs is unable to read the file" do
      let(:file_url) { "/dev/null/fake/file" }
      before do
        Fits.stub(:get_fits_output).and_return('')
      end
      it "should raise an error" do
        expect {
          Fits.analyze(file_url)
        }.to raise_error /FITS call returned nothing/i
      end
    end

    context "when FITs is able to read the file" do

      def get_fits_output_xml
        return open(File.expand_path("../fits_spec-analysis-results.xml", __FILE__), "r") {|f| f.read}
      end

      before :all do
        Fits.stub(:get_fits_output).and_return( get_fits_output_xml() )
        @results = Fits.analyze(file_url)
      end

      it "should return a hash" do
        @results.class.should == Hash
      end

      it "should return a hash with the correct :file_extension" do
        @results[:file_extension].should == ".rb"
      end

      it "should return a hash with the correct :format_name" do
        @results[:format_name].should == "Plain text"
      end

      it "should return a hash with the correct :mime_type" do
        @results[:mime_type].should == "text/plain"
      end

      it "should return a hash with the correct :file_size" do
        @results[:file_size].should == "3095"
      end

      it "should return a hash with the correct :md5" do
        @results[:md5].should == "471f3b7b23fbaea4acabe4605163b894"
      end

      it "should not return an empty format_version value when it can't produce one" do
        @results.should_not have_key :format_version
      end

    end

  end
end
