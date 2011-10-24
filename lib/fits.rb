module Fits

  def self.run_fits(file_id, input_file)
    # Fields returned by this method must match stored_file attribute names so
    # the return value of this method is suitable to pass to model.update_attribute()
    raise "File not found: #{input_file}" unless test(?f, input_file)

    # TODO: use system to call fits with -o $outputfile and check return value to
    # see if FITS crashed. We'll also want to keep fits output XML around for a bit
    # to debug
    fits_output = open("|/home/phunk/camp12/lib/fits/fits.sh -i #{input_file}") {|f| f.read}
    raise "FITS call failed" if fits_output == ''

    ::Rails.logger.debug "FITS: id/filename: #{file_id} - #{input_file}"
    xml = Nokogiri::XML(fits_output)
    xml.remove_namespaces!
    fits_data = {}

    format_node = xml.xpath('//fits/identification/identity[@format != ""]')
    fits_data[:format_name] = format_node.attr('format').value if format_node and format_node.attr('format')
    fits_data[:mime_type] = format_node.attr('mimetype').value if format_node and format_node.attr('mimetype')

    format_version = xml.xpath('//fits/identification/identity/version')
    fits_data[:format_version] = format_version.first.content if format_version and format_version.first

    file_size = xml.xpath('//fits/fileinfo/size')
    fits_data[:file_size] = file_size.first.content if file_size and file_size.first

    md5checksum = xml.xpath('//fits/fileinfo/md5checksum')
    fits_data[:md5] = md5checksum.first.content if md5checksum and md5checksum.first

    return fits_data
  end

end
