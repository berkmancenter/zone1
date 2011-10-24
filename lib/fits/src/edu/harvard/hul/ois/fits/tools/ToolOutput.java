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
package edu.harvard.hul.ois.fits.tools;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.jdom.Document;
import org.jdom.output.XMLOutputter;
import org.xml.sax.InputSource;

import edu.harvard.hul.ois.fits.Fits;
import edu.harvard.hul.ois.fits.exceptions.FitsToolException;
import edu.harvard.hul.ois.fits.identity.FileIdentity;
import edu.harvard.hul.ois.fits.tools.utils.XmlUtils;

public class ToolOutput {	
	//The FITS formatted XML
	private Document fitsXml = null;
	//Wrapper for raw output from the tool
	private Document toolOutput = null;
	//Reference to the tool the output was created with
	private Tool tool;
	//Identification data about the image
	private List<FileIdentity> identity = new ArrayList<FileIdentity>();
	
	public ToolOutput(Tool tool, Document fitsXml, Document toolOutput) throws FitsToolException {
		if(Fits.validateToolOutput && fitsXml !=null && !validateXmlOutput(fitsXml)) {
			throw new FitsToolException(tool.getToolInfo().getName()+" "+
					tool.getToolInfo().getVersion() + " produced invalid FITS XML output");
		}
		
		this.tool = tool;
		this.toolOutput = toolOutput;
		//map values and get identities from fitsXML if not null 
		if(fitsXml != null) {
			//fitsxml doc is mapped here before identities are extracted
			this.fitsXml = Fits.mapper.applyMap(tool,fitsXml);
			identity = XmlUtils.getFileIdentities(fitsXml,tool.getToolInfo());
		}		
	}
	
	public ToolOutput(Tool tool, Document fitsXml) throws FitsToolException {
		this(tool,fitsXml,null);	
	}

	public Tool getTool() {
		return tool;
	}
	
	public Document getFitsXml() {
		return fitsXml;
	}
	
	public void setFitsXml(Document fitsXml) {
		this.fitsXml = fitsXml;
	}
	
	public Document getToolOutput() {
		return toolOutput;
	}
	
	public List<FileIdentity> getFileIdentity() {
		return identity;
	}
	
	public void addFileIdentity(FileIdentity id) {
		identity.add(id);
	}
	
	private boolean validateXmlOutput(Document output) {
		
		try {
			DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
			docBuilderFactory.setNamespaceAware(true);
			docBuilderFactory.setValidating(true);
			docBuilderFactory.setAttribute("http://java.sun.com/xml/jaxp/properties/schemaLanguage", "http://www.w3.org/2001/XMLSchema");
			docBuilderFactory.setAttribute("http://java.sun.com/xml/jaxp/properties/schemaSource", Fits.FITS_HOME+Fits.internalOutputSchema);
			DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
			
			XMLOutputter outputter = new XMLOutputter();
			String xml = outputter.outputString(output);
			
			docBuilder.parse(new InputSource(new StringReader(xml)));
			} 
			catch(Exception e) {
				e.printStackTrace();
				return false;
			} 
			return true;
		
		/*
		SAXBuilder builder =  new SAXBuilder("org.apache.xerces.parsers.SAXParser", true);
		builder.setFeature("http://apache.org/xml/features/validation/schema", true);
		builder.setProperty("http://apache.org/xml/properties/schema/external-schemaLocation",
								Fits.FITS_HOME+Fits.internalOutputSchema);
		
		
		XMLOutputter outputter2 = new XMLOutputter(Format.getPrettyFormat());
		try {
			outputter2.output(output, System.out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		try {
			XMLOutputter outputter = new XMLOutputter();
			String xml = outputter.outputString(output);
			builder.build(new InputSource(new StringReader(xml)));
		} catch (Exception e) {
			
			return false;
		} 
	    return true;*/
	}
	
}
