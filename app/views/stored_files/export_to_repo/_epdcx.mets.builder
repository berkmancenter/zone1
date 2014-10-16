# METS Metadata Wrapper, which contains metadata
# in EPrints DC XML Schema (epdcx) - As necessary for SWORD
# See: http://www.ukoln.ac.uk/repositories/digirep/index/Eprints_Application_Profile
xml.mdWrap(:LABEL=>"SWORD Metadata - EPrints DC XML schema id:#{stored_file.id}", :MDTYPE=>"OTHER", :OTHERMDTYPE=>"EPDCX", :MIMETYPE=>"text/xml") do
  xml.xmlData do
    xml.epdcx(:descriptionSet, 'epdcx:resourceId'=>"sword-mets-epdcx-1") do
      xml.epdcx(:description, 'epdcx:resourceId'=>"sword-mets-epdcx-1") do
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/type", 'epdcx:valueURI'=>"http://purl.org/eprint/entityType/ScholarlyWork")
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/title" ) do
          xml.epdcx(:valueString, encode_for_xml(stored_file.display_name))
        end
        stored_file.tags.each do |tag|
          xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/subject") do
            xml.epdcx(:valueString, encode_for_xml(tag.name))
          end
        end
        xml.epdcx(:statement,  'epdcx:propertyURI'=>"http://purl.org/dc/terms/abstract" ) do
          xml.epdcx(:valueString, encode_for_xml(stored_file.description))
        end
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/creator") do
          xml.epdcx(:valueString, encode_for_xml(stored_file.author))
        end
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/eprint/terms/isExpressedAs", 'epdcx:valueRef'=>"sword-mets-expr-1")
      end
      xml.epdcx(:description, 'epdcx:resourceId'=>"sword-mets-expr-1") do
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/type", 'epdcx:valueURI'=>"http://purl.org/eprint/entityType/Expression")
        if stored_file.description.present?
          xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/description" ) do
            xml.epdcx(:value_string, encode_for_xml(stored_file.description))
          end
        end
        if stored_file.copyright_holder.present?
          xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/eprint/terms/copyrightHolder" ) do
            xml.epdcx(:valueString, encode_for_xml(stored_file.copyright_holder))
          end
        end
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://www.loc.gov/loc.terms/relators/EDT") do
          xml.epdcx(:valueString, encode_for_xml(stored_file.contributor_name))
        end
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/eprint/terms/isManifestedAs", 'epdcx:valueRef'=>"sword-mets-manifest-#{stored_file.id}" )
        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/format", 'epdcx:valueURI'=>"http://purl.org/dc/terms/IMT") do
          xml.epdcx(:valueString, encode_for_xml(stored_file.mime_type.try(:mime_type)))
        end
      end
#      work.attachments.each do |att|

#      filepath = stored_file.original_filename
#      xml.epdcx(:description, 'epdcx:resourceId'=>"sword-mets-manifest-#{stored_file.id}" ) do
#        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/type", 'epdcx:valueURI'=>"http://purl.org/eprint/entityType/Manifestation")
#        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/format", 'epdcx:valueURI'=>"http://purl.org/dc/terms/IMT") do
#          xml.epdcx(:valueString, encode_for_xml(stored_file.mime_type.try(:mime_type)))
#        end
#        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/eprint/terms/isAvailableAs", 'epdcx:valueURI'=> filepath)
#      end
#      xml.epdcx(:description, 'epdcx:resourceURI'=>filepath ) do
#        xml.epdcx(:statement, 'epdcx:propertyURI'=>"http://purl.org/dc/elements/1.1/type", 'epdcx:valueURI'=>"http://purl.org/eprint/entityType/Copy")
#      end

#      end
    end
  end
end
