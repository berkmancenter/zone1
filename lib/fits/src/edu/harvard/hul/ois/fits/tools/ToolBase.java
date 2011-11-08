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

import java.io.File;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;

import net.sf.saxon.Configuration;
import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.jdom.DocumentWrapper;

import org.jdom.input.SAXBuilder;
import org.jdom.transform.JDOMResult;
import org.jdom.Document;
import edu.harvard.hul.ois.fits.exceptions.FitsToolException;
import edu.harvard.hul.ois.fits.identity.FileIdentity;

public abstract class ToolBase implements Tool {
	
	protected ToolInfo info = null;
	protected ToolOutput output = null;
	protected SAXBuilder saxBuilder;
	protected TransformerFactory tFactory;
    protected Hashtable transformMap;
    
    private List<String> excludedExtensions;
	
	public ToolBase() throws FitsToolException {
		info = new ToolInfo();
		//System.setProperty("javax.xml.transform.TransformerFactory","net.sf.saxon.TransformerFactoryImpl");
		tFactory = TransformerFactory.newInstance ();
		saxBuilder = new SAXBuilder();
		excludedExtensions = new ArrayList<String>();
	}
	
	public ToolInfo getToolInfo() {
		return info;
	}
	
	public Boolean canIdentify() {
		return true;
	}
	
	public boolean isIdentityKnown(FileIdentity identity) {
		if(!canIdentify()) {
			return false;
		}
		//identity and mimetype must not be null or empty strings for an identity to be "known"		
		if(identity == null
				|| identity.getMime() == null 
				|| identity.getMime().length() == 0
				|| identity.getFormat() == null 
				|| identity.getFormat().length() == 0) {
			return false;
		}
		String format = identity.getFormat();
		String mime = identity.getMime();
		if(format.equals("Unknown Binary") || mime.equals("application/octet-stream")) {
			return false;
		}
		else {
			return true;
		}
	}
		
	public Boolean validate(File files_or_dir, FileIdentity identity) {
		return null;
	}

	public Document transform(String xslt, Document input) throws FitsToolException {
		Document doc = null;
		try {
			Configuration config = ((TransformerFactoryImpl)tFactory).getConfiguration();
			DocumentWrapper docw = new DocumentWrapper(input,null,config);
			JDOMResult out = new JDOMResult();
			Templates templates = tFactory.newTemplates(new StreamSource(xslt));
			Transformer transformer = templates.newTransformer();
			transformer.transform(docw, out);
			doc = out.getDocument();
		}
		catch(Exception e) {
			throw new FitsToolException(info.getName()+": Error converting output using "+xslt,e);
		}
		return doc;
	}
	
	public void addExcludedExtension(String ext) {
		excludedExtensions.add(ext);
	}
	
	public boolean hasExcludedExtension(String ext) {
		for(String extension : excludedExtensions) {
			if(extension.equalsIgnoreCase(ext)) {
				return true;
			}
		}
		return false;
	}
	
	public void resetOutput() {
		output = null;
	}

}
