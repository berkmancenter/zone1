def encode_for_xml(data)
  HTMLEntities.new.encode(data, :basic)
end

xml.instruct!
xml.mets(:OBJID=>"sword-mets", :LABEL=>"ZoneOne SWORD package", :PROFILE=>"DSpace METS SIP Profile 1.0", :xmlns=>"http://www.loc.gov/METS/", 'xmlns:xlink'=>"http://www.w3.org/1999/xlink", 'xmlns:xsi'=>"http://www.w3.org/2001/XMLSchema-instance", 'xsi:schemaLocation'=>"http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/mets.xsd", 'xmlns:epdcx' => 'http://purl.org/eprint/epdcx/2006-11-16/') do
  xml.metsHdr(:CREATEDATE => DateTime.now.to_s(:xsd)) do
    xml.agent(:ROLE=>"CREATOR", :TYPE=>"OTHER") do
      xml.name("ZoneOne")
    end
  end
  xml.dmdSec(:ID => "sword-mets-dmd-1", :CREATED => DateTime.now.to_s(:xsd)) do
    xml << render('stored_files/export_to_repo/epdcx.mets', {:stored_file => stored_file, :filenames_only => true})
  end
  xml.fileSec do
    xml.fileGrp(:ID=>"sword-mets-fgrp-1", :USE=>"CONTENT") do
      xml.file(:ID=>"sword-mets-file-#{stored_file.id}", :MIMETYPE=>stored_file.mime_type.try(:mime_type), :SIZE=>stored_file.file_size) do
        xml.FLocat(:LOCTYPE=>"URL", "xlink:href"=>stored_file.original_filename)
      end
    end
  end
  xml.structMap(:ID=>"sword-mets-struct-1", :TYPE=>"LOGICAL") do
    xml.div(:ID=>"sword-mets-struct-div-1", :DMDID=>"sword-mets-dmd-1", :TYPE=>"SWORD Object") do
      xml.div(:ID=>"sword-mets-struct-file-#{stored_file.id}", :TYPE=>"FILE") do
        xml.fptr(:FILEID=>"sword-mets-file-#{stored_file.id}")
      end
    end
  end
end
