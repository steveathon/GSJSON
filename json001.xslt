<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="utf-8"/>
	
	<xsl:template match='GSP'>
		<xsl:text>{"GSP":{</xsl:text>
			"TM": "<xsl:value-of select="TM" />",
			"Q": "<xsl:value-of select="Q" />",
			"PARAM": [
			<xsl:for-each select='PARAM'>
			{
				<xsl:for-each select="@*">
					"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
					<xsl:if test="position() != last()">,
					</xsl:if>
				</xsl:for-each>
			}
				<xsl:if test='position() != last()'>,
				</xsl:if>
			</xsl:for-each>]
			<xsl:choose>
			<xsl:when test='RES'>,<xsl:apply-templates select='RES' />
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			
		<xsl:text>}}</xsl:text>
	</xsl:template>
	
	<xsl:template match="RES">
	"RES": {
				"SN": "<xsl:value-of select="@SN" />",
				"EN": "<xsl:value-of select="@EN" />",
				"M": "<xsl:value-of select="M" />",
				<xsl:if test='R'>
				"R": [
					<xsl:for-each select='R'>
					{
					"N":"<xsl:value-of select='@N' />",
					"U":"<xsl:value-of select='U' />",
					"UE":"<xsl:value-of select='UE' />",
					"ED":"<xsl:value-of select='ED' />",
					"T":"<xsl:value-of select='T' />",
					"RK":"<xsl:value-of select='RK' />",
					"FS": {	<xsl:for-each select="@*">
								"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
								<xsl:if test="position() != last()">,</xsl:if>
							</xsl:for-each>},
					"S": "",
					"LANG": "<xsl:value-of select='LANG'/>"
					<xsl:choose>
						<xsl:when test='HAS'>
							,<xsl:apply-templates select='HAS' />
						</xsl:when>
					<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
					
					}<xsl:if test='position() != last()'>,</xsl:if>
					</xsl:for-each>
				]
				</xsl:if>
			}
	</xsl:template>
	
	<xsl:template match='HAS'>
	"HAS": {
					"L":"<xsl:value-of select='L' />",
					"C": {<xsl:for-each select="C/@*">
								"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
								<xsl:if test="position() != last()">,</xsl:if>
							</xsl:for-each>} 
						}
	</xsl:template>
	
<xsl:template match="@*|node()"/>

</xsl:stylesheet>
