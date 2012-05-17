/* 
 * Copyright 2009 Harvard University Library
 * 
 * This file is part of FITS (File Information Tool Set).
 * 
 * FITS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * FITS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with FITS.  If not, see <http://www.gnu.org/licenses/>.
 */
package edu.harvard.hul.ois.fits;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.jdom.xpath.XPath;

import edu.harvard.hul.ois.fits.consolidation.FitsIdentitySection;
import edu.harvard.hul.ois.ots.schemas.AES.AudioObject;
import edu.harvard.hul.ois.ots.schemas.DocumentMD.DocumentMD;
import edu.harvard.hul.ois.ots.schemas.MIX.Mix;
import edu.harvard.hul.ois.ots.schemas.TextMD.TextMD;
import edu.harvard.hul.ois.ots.schemas.XmlContent.XmlContent;

public class FitsOutput {
	
	private Document fitsXml;          // This is in the FITS XML format
	private List<FitsIdentitySection> identities;
	private List<Exception> caughtExceptions = new ArrayList<Exception>();
	private Namespace ns = Namespace.getNamespace(Fits.fitsXmlNamespace);
	
	public FitsOutput(Document fitsXml,List<FitsIdentitySection> identities) {
		this.fitsXml = fitsXml;
		this.identities = identities;
	}
		
	public void setFitsXml(Document fitsXml) {
		this.fitsXml = fitsXml;
	}

	public Document getFitsXml() {
		return fitsXml;
	}
	
	public List<FitsIdentitySection> getIdentities() {
		return identities;
	}

	public void setIdentities(List<FitsIdentitySection> identities) {
		this.identities = identities;
	}
	
	public List<Exception> getCaughtExceptions() {
		return caughtExceptions;
	}

	public void setCaughtExceptions(List<Exception> caughtExceptions) {
		this.caughtExceptions = caughtExceptions;
	}
	
	public List<FitsMetadataElement> getFileInfoElements() {
		Element root = fitsXml.getRootElement();
		Element fileInfo = root.getChild("fileinfo",ns);
		return buildMetadataList(fileInfo);
	}
	
	public List<FitsMetadataElement> getFileStatusElements() {
		Element root = fitsXml.getRootElement();
		Element fileStatus = root.getChild("filestatus",ns);
		return buildMetadataList(fileStatus);
	}
		
	public List<FitsMetadataElement> getTechMetadataElements() {
		Element root = fitsXml.getRootElement();
		Element metadata = (Element)root.getChild("metadata",ns);
		if(metadata.getChildren().size() > 0) {
			Element techMetadata = (Element)root.getChild("metadata",ns).getChildren().get(0);
			return buildMetadataList(techMetadata);
		}
		else {
			return null;
		}
	}
	
	public String getTechMetadataType() {
		Element root = fitsXml.getRootElement();
		Element metadata = (Element)root.getChild("metadata",ns);
		if(metadata.getChildren().size() > 0) {
			Element techMetadata = (Element)root.getChild("metadata",ns).getChildren().get(0);
			return techMetadata.getName();
		}
		else {
			return null;
		}
	}
	
	public FitsMetadataElement getMetadataElement(String name) {
		try {			
			XPath xpath = XPath.newInstance("//fits:"+name);
			xpath.addNamespace("fits",Fits.fitsXmlNamespace);
			Element node = (Element)xpath.selectSingleNode(fitsXml);
			if(node != null) {
				FitsMetadataElement element = buildMetdataIElements(node);
				return element;
			}
		} catch (JDOMException e) {
			//do nothing
		}
		return null;
	}
	
	public List<FitsMetadataElement> getMetadataElements(String name) {
		List<FitsMetadataElement> elements = new ArrayList<FitsMetadataElement>();
		try {
			XPath xpath = XPath.newInstance("//fits:"+name);
			xpath.addNamespace("fits",Fits.fitsXmlNamespace);
			List<Element> nodes = xpath.selectNodes(fitsXml);
			for(Element e : nodes) {
				elements.add(buildMetdataIElements(e));
			}
			return elements;
		} catch (JDOMException e) {
			//do nothing
		}
		return null;
	}
	
	public boolean hasMetadataElement(String name) {
		FitsMetadataElement element = getMetadataElement(name);
		if(element != null) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public Boolean hasConflictingMetadataElements(String name) {
		List<FitsMetadataElement> elements = getMetadataElements(name);
		if(elements.size() > 1) {
			String elementStatus = elements.get(0).getStatus();
			if(elementStatus != null && elementStatus.equalsIgnoreCase("conflict")) {
				return true;
			}
			else {
				return false;
			}		
		}
		else {
			return null;
		}
	}
	
	private List buildMetadataList(Element parent) {
		List<FitsMetadataElement> data = new ArrayList<FitsMetadataElement>();
		if(parent == null) {
			return null;
		}
		for(Element child : (List<Element>)parent.getChildren()) {
			data.add(buildMetdataIElements(child));
		}
		return data;
	}
	
	private FitsMetadataElement buildMetdataIElements(Element node) {
		FitsMetadataElement element = new FitsMetadataElement();
		element.setName(node.getName());
		element.setValue(node.getValue());
		Attribute toolName = node.getAttribute("toolname");
		if(toolName != null) {
			element.setReportingToolName(toolName.getValue());
		}
		Attribute toolVersion = node.getAttribute("toolversion");
		if(toolVersion != null) {
			element.setReportingToolVersion(toolVersion.getValue());
		}
		Attribute status = node.getAttribute("status");
		if(status != null) {
			element.setStatus(status.getValue());
		}
		return element;
	}
	
	public void saveToDisk(String location) throws IOException {
		XMLOutputter serializer = new XMLOutputter(Format.getPrettyFormat());
		OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(location),"UTF-8");
		serializer.output(fitsXml, out);
		out.close();
	}
	
	public void output(OutputStream outstream) throws IOException {
		XMLOutputter serializer = new XMLOutputter(Format.getPrettyFormat());
		OutputStreamWriter out = new OutputStreamWriter(outstream,"UTF-8");
		serializer.output(fitsXml, out);
		out.close();
	}
	
    public Boolean checkWellFormed() {
		FitsMetadataElement wellFormed = getMetadataElement("well-formed");	
		if(wellFormed != null) {
			return Boolean.valueOf(wellFormed.getValue());
		}
		return null;
    }
    
    public Boolean checkValid() {
		FitsMetadataElement valid = getMetadataElement("valid");	
		if(valid != null) {
			return Boolean.valueOf(valid.getValue());
		}
		return null;    
    }
    
    public String getErrorMessages() {
    	List<FitsMetadataElement> statusElements = getFileStatusElements();
    	String errorMessages = new String();
		for(FitsMetadataElement element : statusElements) {
			if(element.getName() == "message") {
				errorMessages = errorMessages+"\n"+element.getValue();
			}
		}
		return errorMessages;	
    }
		
    /** Return an XmlContent object representing the data from fitsXml. */
    public XmlContent getStandardXmlContent () {
        Element metadata = fitsXml.getRootElement().getChild("metadata",ns);
        
        if(metadata == null) {
        	return null;
        }
        
        XmlContentConverter conv = new XmlContentConverter ();
        
        //Element metadata = root.getChild("metadata");
        // This can have an image, document, text, or audio subelement.
        Element subElem = metadata.getChild ("image",ns);
        if (subElem != null) {
        	Element fileinfo = fitsXml.getRootElement().getChild("fileinfo",ns);
            // Process image metadata...
        	return (Mix) conv.toMix (subElem,fileinfo);
        }
        subElem = metadata.getChild ("text",ns);
        if (subElem != null) {
        	// Process text metadata...
        	return (TextMD) conv.toTextMD (subElem);
        }
        subElem = metadata.getChild ("document",ns);
        if (subElem != null) {
            // Process document metadata...
        	return (DocumentMD)conv.toDocumentMD (subElem);
        }
        subElem = metadata.getChild ("audio",ns);
        if (subElem != null) {
            // Process audio metadata...
        	return (AudioObject)conv.toAES (this,subElem);
        }
        return null;
    }
}
