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
package edu.harvard.hul.ois.fits.consolidation;

import java.util.ArrayList;
import java.util.List;

import edu.harvard.hul.ois.fits.identity.ExternalIdentifier;
import edu.harvard.hul.ois.fits.identity.FileIdentity;
import edu.harvard.hul.ois.fits.identity.FormatVersion;
import edu.harvard.hul.ois.fits.tools.ToolInfo;
/**
 * Wraps FileIdentity with the tool information that reported it
 * @author spmcewen
 *
 */
public class FitsIdentitySection {
	private String format;
	private String mimetype;
	private List<FormatVersion> formatVersions = new ArrayList<FormatVersion>();
	private List<ToolInfo> reportingTools = new ArrayList<ToolInfo>();
	private List<ExternalIdentifier> externalIDs = new ArrayList<ExternalIdentifier>();
	
	public FitsIdentitySection() {
		
	}
	
	public FitsIdentitySection(FileIdentity identity) {
		this.format = identity.getFormat();
		this.mimetype = identity.getMime();
		if(identity.getFormatVersionValue() != null) {
			formatVersions.add(identity.getFormatVersion());
		}
		externalIDs.addAll(identity.getExternalIds());
		reportingTools.add(identity.getToolInfo());
	}
	
	public String getFormat() {
		return format;
	}
	
	public String getMimetype() {
		return mimetype;
	}
	
	public void setFormat(String format) {
		this.format = format;
	}
	
	public void setMimetype(String mimetype) {
		this.mimetype = mimetype;
	}
	
	public FitsIdentitySection(String format, String mimetype) {
		this.format = format;
		this.mimetype = mimetype;
	}
	
	public void addFormatVersion(FormatVersion version) {
		formatVersions.add(version);
	}
	
	public List<FormatVersion> getFormatVersions() {
		return formatVersions;
	}
	
	public void setFormatVersions(List<FormatVersion> versions) {
		formatVersions = versions;
	}
	
	public void addExternalID(ExternalIdentifier identifier) {
		externalIDs.add(identifier);
	}
	
	public List<ExternalIdentifier> getExternalIdentifiers() {
		return externalIDs;
	}

	/**
	 * Adds a ToolInfo object to the reported tools list only if one with the same
	 * name and version has not already been added.
	 * @param info
	 */
	public void addReportingTool(ToolInfo info) {
		for(ToolInfo reportedInfo : reportingTools) {
			String Name = reportedInfo.getName();
			String version = reportedInfo.getVersion();
			if(Name.equalsIgnoreCase(info.getName()) && version.equalsIgnoreCase(info.getVersion())) {
				return;
			}
		}
		reportingTools.add(info);
	}
	
	public List<ToolInfo> getReportingTools() {
		return reportingTools;
	}

	public boolean hasExternalIdentifier(ExternalIdentifier xid) {
		for(ExternalIdentifier externalID : externalIDs) {
			if(externalID.getName().equalsIgnoreCase(xid.getName())
					&& externalID.getValue().equalsIgnoreCase(xid.getValue())) {
				return true;
			}
		}
		return false;
	}

	public boolean hasFormatVersion(FormatVersion version) {
		for(FormatVersion v : formatVersions) {
			String vValue = v.getValue();
			if(vValue != null) {
				//check as strings first
				if(vValue.equalsIgnoreCase(version.getValue())) {
					return true;
				}
				//try as Version objects
				else {
					VersionComparer v1 = VersionComparer.parse(vValue);
					VersionComparer v2 = VersionComparer.parse(version.getValue());
					if(v1.isEquivalentTo(v2)) {
						return true;
					}				
				}
			}
		}
		return false;
	}
	
	public boolean hasOutputFromTool(ToolInfo info) {
		if(reportingTools.contains(info)) {
			return true;
		}
		else {
			return false;
		}
	}

}
