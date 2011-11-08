#!/usr/local/bin/ruby -wrubygems
require 'nokogiri'


def run_fits_on_file(file_id, input_file)
  raise "File not found: #{input_file}" unless test(?f, input_file)

  #todo use system to call fits with -o $outputfile and check return value to see if FITS crashed
  fits_output = open("|./fits.sh -i #{input_file}") {|f| f.read}
  raise "FITS call failed" if fits_output == ''
  
  xml = Nokogiri::XML(fits_output)
  xml.remove_namespaces!
  fits_data = {}

  format_name = xml.xpath('//fits/identification/identity[@format != ""]')
  fits_data[:format_name] = format_name.attr('format').value if format_name and format_name.attr('format')

  format_version = xml.xpath('//fits/identification/identity/version')
  fits_data[:format_version] = format_version.first.content if format_version and format_version.first

  file_size = xml.xpath('//fits/fileinfo/size')
  fits_data[:filesize] = file_size.first.content if file_size and file_size.first

  md5checksum = xml.xpath('//fits/fileinfo/md5checksum')
  fits_data[:md5] = md5checksum.first.content if md5checksum and md5checksum.first

  return fits_data
end
#p run_fits_on_file(1, 'wireframes2.pdf')

