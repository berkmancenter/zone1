module Fits

  def self.analyze(file_url)
    ::Rails.logger.debug "PHUNK: entering Fits::analyze()"
    # Fields returned by this method must match stored_file attribute names so
    # the return value of this method is suitable to pass to model.update_attribute()
    raise "File not found: #{file_url}" unless test(?f, file_url)

    # TODO: use system to call fits with -o $outputfile and check return value to
    # see if FITS crashed. We'll also want to keep fits output XML around for a bit
    # to debug
    fits_output = open("|/usr/local/bin/fits/fits.sh -i #{file_url}") {|f| f.read}
    raise "FITS call failed" if fits_output == ''

    xml = Nokogiri::XML(fits_output)
    xml.remove_namespaces!
    fits_data = {}

    format_node = xml.xpath('//fits/identification/identity[@format != ""]')
    format_name = format_node.attr('format').value if format_node and format_node.attr('format')
    mime_type = format_node.attr('mimetype').value if format_node and format_node.attr('mimetype')
    fits_data[:fits_mime_type] = { :format_name => format_name, :mime_type => mime_type }

    format_version = xml.xpath('//fits/identification/identity/version')
    fits_data[:format_version] = format_version.first.content if format_version and format_version.first

    file_size = xml.xpath('//fits/fileinfo/size')
    fits_data[:file_size] = file_size.first.content if file_size and file_size.first

    md5checksum = xml.xpath('//fits/fileinfo/md5checksum')
    fits_data[:md5] = md5checksum.first.content if md5checksum and md5checksum.first

    return fits_data
  end

end
