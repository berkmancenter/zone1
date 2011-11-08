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
package edu.harvard.hul.ois.fits.tools.oisfileinfo;

import java.io.File;
import java.io.IOException;

import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;

import com.twmacinta.util.MD5;

import edu.harvard.hul.ois.fits.Fits;
import edu.harvard.hul.ois.fits.exceptions.FitsToolException;
import edu.harvard.hul.ois.fits.tools.ToolBase;
import edu.harvard.hul.ois.fits.tools.ToolOutput;

public class FileInfo extends ToolBase {
	
	private boolean enabled = true;
	
	public FileInfo() throws FitsToolException{
		info.setName("OIS File Information");
		info.setVersion("0.1");
		info.setDate(null);
	}

	public ToolOutput extractInfo(File file) throws FitsToolException {	
		Document doc = createXml(file);
		output = new ToolOutput(this,(Document)doc.clone(),doc);
		return output;
	}
	
	private Document createXml(File file) throws FitsToolException {
		
		Namespace xsiNS = Namespace.getNamespace("xsi","http://www.w3.org/2001/XMLSchema-instance");
		Namespace fitsNS = Namespace.getNamespace(Fits.fitsXmlNamespace);
		
		Element root = new Element("fits",fitsNS);
		root.setAttribute(new Attribute("schemaLocation","http://hul.harvard.edu/ois/xml/ns/fits/fits_output "+Fits.externalOutputSchema,xsiNS));
		//fileinfo section
		Element fileInfo = new Element("fileinfo",fitsNS);
		//filename
		Element fileName = new Element("filename",fitsNS);
		fileName.setText(file.getPath());
		fileInfo.addContent(fileName);
		//size
		Element size = new Element("size",fitsNS);
		size.setText(String.valueOf(file.length()));
		fileInfo.addContent(size);		
		//Calculate the MD5 checksum
		try {
			String md5Hash = MD5.asHex(MD5.getHash(new File(file.getPath())));
			Element signature = new Element("md5checksum",fitsNS);
			signature.setText(md5Hash);
			fileInfo.addContent(signature);
		} catch (IOException e) {
			throw new FitsToolException("Could not calculate the MD5 for "+file.getPath(),e);
		}
		//fslastmodified
		Element fslastmodified = new Element("fslastmodified",fitsNS);
		fslastmodified.setText(String.valueOf(file.lastModified()));
		fileInfo.addContent(fslastmodified);
		root.addContent(fileInfo);
		
		return new Document(root);
    }
	public Boolean canIdentify() {
		return false;
	}

	
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean value) {
		enabled = value;		
	}
}
