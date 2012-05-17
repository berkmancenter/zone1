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
package edu.harvard.hul.ois.fits.tools.utils;

import java.util.ArrayList;
import java.util.List;


import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.xpath.XPath;

import edu.harvard.hul.ois.fits.Fits;
import edu.harvard.hul.ois.fits.identity.ExternalIdentifier;
import edu.harvard.hul.ois.fits.identity.FileIdentity;
import edu.harvard.hul.ois.fits.tools.ToolInfo;

public class XmlUtils {
			
    /**
     * Returns the first value of the element in the provided dom object.  Returns
     * empty string if not found.
     * @param dom
     * @param element
     * @return the element value or empty string
     */
	public static String getDomValue(Document dom, String element) {
		try {
			Element e = (Element)XPath.selectSingleNode(dom,"//"+element);
			if(e != null) {
				return e.getText();
			}
		} catch (JDOMException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * concatenates the values of all elements children into a single string and returns it
	 * @param dom
	 * @param element
	 * @return
	 */
	public static String getChildDomValues(Document dom, String element) {
		String s = "";
		try {
			Element e = (Element)XPath.selectSingleNode(dom,"//"+element);
			if(e != null) {				
				for(Element ee : (List<Element>)e.getChildren()) {
					s = s + ee.getText() + " ";
				}
				return s;
			}
		} catch (JDOMException e) {
			e.printStackTrace();
		}
		return null;
	}
/*	
	public static Document wrapInDom(String elementName, String text) {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = null;
		try {
			docBuilder = factory.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
		
		Document dom = docBuilder.newDocument();
		Element element = dom.createElement(elementName);
		CDATASection cdata = dom.createCDATASection(text);
		element.appendChild(cdata);
		dom.appendChild(element);
		return dom;
	}
*/	
	/*
	public static void printToConsole(Document dom) {	
		XMLOutputter outputter = new XMLOutputter(); 
		try {
			outputter.output(dom, System.out);
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}*/
	
	/*
	public static Element getChildWithAttribute(Element parent, String attName, String attValue) {
		for(Element e:(List<Element>)parent.getChildren()) {
			Attribute attr = e.getAttribute(attName);
			if(attr != null && attr.getValue().equalsIgnoreCase(attValue)) {
				return e;
			}
		}
		return null;
	}*/
		
	public static Element getChildWithAttribute(Element e, Attribute a) {
		Element foundE = null;
		Attribute aa = e.getAttribute(a.getName());
		if(aa != null && aa.getValue().equalsIgnoreCase(a.getValue())) {
			return e;
		}
		for(Element ee:(List<Element>)e.getChildren()) {
			foundE = getChildWithAttribute(ee,a);
			if(foundE != null) {
				break;
			}
		}
		return foundE;
	}
	
	public static List<FileIdentity> getFileIdentities(Document dom, ToolInfo info) {
		List<FileIdentity> identities = new ArrayList<FileIdentity>();
		try {
			XPath xpath = XPath.newInstance("//fits:identity");
			Namespace ns = Namespace.getNamespace("fits",Fits.fitsXmlNamespace);
			xpath.addNamespace(ns);
			List<Element> identElements = xpath.selectNodes(dom);
			for(Element element : identElements) {
				Attribute formatAttr = element.getAttribute("format");
				Attribute mimetypeAttr = element.getAttribute("mimetype");
				Element versionElement = element.getChild("version",ns);
				
				String format = null;
				String mimetype = null;
				String version = null;
				
				if(formatAttr != null) {
					format = formatAttr.getValue();
				}
				if(mimetypeAttr != null) {
					mimetype = mimetypeAttr.getValue();
				}
				if(versionElement != null) {
					version = versionElement.getText();
				}
				FileIdentity identity = new FileIdentity(mimetype,format,version,info);
				List<Element> xIDElements = element.getChildren("externalIdentifier",ns);
				for(Element xIDElement : xIDElements) {
					String type = xIDElement.getAttributeValue("type");
					String value = xIDElement.getText();
					ExternalIdentifier xid = new ExternalIdentifier(type,value,info);
					identity.addExternalIdentifier(xid);
				}
				identities.add(identity);
			}
		} catch (JDOMException e) {
			e.printStackTrace();
		}
		return identities;
	}

}
