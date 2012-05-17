<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="exiftool_common_to_fits.xslt"/>
<xsl:template match="/">

    <fits xmlns="http://hul.harvard.edu/ois/xml/ns/fits/fits_output"
    	  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://hul.harvard.edu/ois/xml/ns/fits/fits_output xml/fits_output.xsd">
		<xsl:apply-imports/>
		
		<metadata>
			<video>
				<duration>
					<xsl:value-of select="exiftool/Duration"/>
				</duration>
				
				<xsl:choose>
					<xsl:when test="exiftool/AvgBitRate">
						<bitRate>
							<xsl:value-of select="exiftool/AvgBitRate"/>
						</bitRate>
					</xsl:when>
					<xsl:when test="exiftool/VideoBitrate and exiftool/AudioBitrate">
						<bitRate>
							<xsl:value-of select="exiftool/VideoBitrate + exiftool/AudioBitrate"/>
						</bitRate>
					</xsl:when>				
					<xsl:when test="exiftool/VideoBitrate">
						<bitRate>
							<xsl:value-of select="exiftool/VideoBitrate"/>
						</bitRate>
					</xsl:when>				
					<xsl:when test="exiftool/AudioBitrate">
						<bitRate>
							<xsl:value-of select="exiftool/AudioBitrate"/>
						</bitRate>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="exiftool/VideoFrameRate">
						<frameRate>
							<xsl:value-of select="exiftool/VideoFrameRate"/>
						</frameRate>
					</xsl:when>
					<xsl:when test="exiftool/FrameRate">
						<frameRate>
							<xsl:value-of select="exiftool/FrameRate"/>
						</frameRate>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="exiftool/BitDepth">
						<bitDepth>
							<xsl:value-of select="exiftool/BitDepth"/>
						</bitDepth>
					</xsl:when>
					<xsl:when test="exiftool/BitsPerSample">
						<bitDepth>
							<xsl:value-of select="exiftool/BitsPerSample"/>
						</bitDepth>
					</xsl:when>
					<xsl:when test="exiftool/SampleSize">
						<bitDepth>
							<xsl:value-of select="exiftool/SampleSize"/>
						</bitDepth>
					</xsl:when>
					<xsl:when test="exiftool/AudioSampleBits">
						<bitDepth>
							<xsl:value-of select="exiftool/AudioSampleBits"/>
						</bitDepth>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="exiftool/SampleRate">
						<sampleRate>
							<xsl:value-of select="exiftool/SampleRate"/>
						</sampleRate>
					</xsl:when>
					<xsl:when test="exiftool/AudioSampleRate">
						<sampleRate>
							<xsl:value-of select="exiftool/AudioSampleRate"/>
						</sampleRate>
					</xsl:when>
				</xsl:choose>
	
				<xsl:choose>
					<!-- WAV/FLAC -->
					<xsl:when test="exiftool/NumChannels">
						<channels>
							<xsl:value-of select="exiftool/NumChannels"/>
						</channels>
					</xsl:when>
					<!-- OGG -->
					<xsl:when test="exiftool/AudioChannels">
						<channels>
							<xsl:value-of select="exiftool/AudioChannels"/>
						</channels>
					</xsl:when>
					<!-- MP3 -->
					<xsl:when test="exiftool/ChannelMode">
						<channels>
							<xsl:value-of select="exiftool/ChannelMode"/>
						</channels>
					</xsl:when>
					<!-- FLAC -->
					<xsl:when test="exiftool/Channels">
						<channels>
							<xsl:value-of select="exiftool/Channels"/>
						</channels>
					</xsl:when>
				</xsl:choose>
				
				<imageWidth>
					<xsl:value-of select="exiftool/ImageWidth"/>
				</imageWidth>
				
				<imageHeight>
					<xsl:value-of select="exiftool/ImageHeight"/>
				</imageHeight>
				
				<xsl:choose>
			  		<xsl:when test="string(exiftool/CaptureXResolution)">
		  				<xSamplingFrequency>
					  		<xsl:value-of select="exiftool/CaptureXResolution"/>
						</xSamplingFrequency>
			  		</xsl:when>
			  		<xsl:when test="string(exiftool/XResolution)">
		  				<xSamplingFrequency>
					  		<xsl:value-of select="exiftool/XResolution"/>
						</xSamplingFrequency>
			  		</xsl:when>
				</xsl:choose>
							
				<xsl:choose>
			  		<xsl:when test="string(exiftool/CaptureYResolution)">
		  				<ySamplingFrequency>
					  		<xsl:value-of select="exiftool/CaptureYResolution"/>
						</ySamplingFrequency>
			  		</xsl:when>
			  		<xsl:when test="string(exiftool/YResolution)">
		  				<ySamplingFrequency>
					  		<xsl:value-of select="exiftool/YResolution"/>
						</ySamplingFrequency>
			  		</xsl:when>
				</xsl:choose>	
				
				<xsl:choose>
					<xsl:when test="exiftool/Encoding">
						<dataFormatType>	
							<xsl:value-of select="exiftool/Encoding"/>
						</dataFormatType>	
					</xsl:when>
					<xsl:when test="exiftool/VideoEncoding and exiftool/AudioEncoding">
						<dataFormatType>	
							<xsl:value-of select="concat(exiftool/VideoEncoding, ' + ', exiftool/AudioEncoding)"/>
						</dataFormatType>	
					</xsl:when>
					<xsl:when test="exiftool/VideoEncoding">
						<dataFormatType>	
							<xsl:value-of select="exiftool/VideoEncoding"/>
						</dataFormatType>	
					</xsl:when>
					<xsl:when test="exiftool/AudioEncoding">
						<dataFormatType>	
							<xsl:value-of select="exiftool/AudioEncoding"/>
						</dataFormatType>	
					</xsl:when>
				</xsl:choose>
				
				<blockSizeMin>
					<xsl:value-of select="exiftool/BlockSizeMin"/>
				</blockSizeMin>
					
				<blockSizeMax>
					<xsl:value-of select="exiftool/BlockSizeMax"/>
				</blockSizeMax>
					
				<xsl:choose>
					<xsl:when test="exiftool/CompressorName">
						<creatingApplicationName>
							<xsl:value-of select="exiftool/CompressorName"/>
						</creatingApplicationName>
					</xsl:when>
					<xsl:when test="exiftool/CompressorID">
						<creatingApplicationName>
							<xsl:value-of select="exiftool/CompressorID"/>
						</creatingApplicationName>
					</xsl:when>
				</xsl:choose>		
			</video>			
		</metadata>
	</fits>	

</xsl:template>
</xsl:stylesheet>

