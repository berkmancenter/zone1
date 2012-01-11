module Fits

  def self.analyze(file_url)
    # Fields returned must match stored_file attributes or setters such that the
    # return value of this method is suitable to pass to model.update_attribute()
    ::Rails.logger.info "FITS.analyze firing for #{file_url}"
    raise "File not found: #{file_url}" unless File.exists? file_url

    fits_output = open("|#{FITS_SCRIPT_PATH} -i #{file_url}") {|f| f.read}
    raise "FITS call failed" if fits_output == ''

    xml = Nokogiri::XML(fits_output)
    xml.remove_namespaces!
    format_node = xml.xpath('//fits/identification/identity[@format != ""]')

    metadata = {:file_extension => File.extname(file_url).downcase}

    format_name = format_node.attr('format').value if format_node and format_node.attr('format')
    metadata[:format_name] = format_name

    mime_type = format_node.attr('mimetype').value if format_node and format_node.attr('mimetype')
    metadata[:mime_type] = mime_type

    format_version = xml.xpath('//fits/identification/identity/version')
    metadata[:format_version] = format_version.first.content if format_version and format_version.first

    file_size = xml.xpath('//fits/fileinfo/size')
    metadata[:file_size] = file_size.first.content if file_size and file_size.first

    md5checksum = xml.xpath('//fits/fileinfo/md5checksum')
    metadata[:md5] = md5checksum.first.content if md5checksum and md5checksum.first

    metadata
  end

end
