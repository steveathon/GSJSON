<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" indent="no" media-type="application/json"/>

<xsl:variable name="truncate_result_urls">1</xsl:variable>
<xsl:variable name="truncate_result_url_length">100</xsl:variable>

<!-- *** db_url_protocol: googledb:// *** -->
<xsl:variable name="db_url_protocol">googledb://</xsl:variable>

<!-- *** googleconnector_protocol: googleconnector:// *** -->
<xsl:variable name="googleconnector_protocol">googleconnector://</xsl:variable>

<!-- *** nfs_url_protocol: nfs:// *** -->
<xsl:variable name="nfs_url_protocol">nfs://</xsl:variable>

<!-- *** smb_url_protocol: smb:// *** -->
<xsl:variable name="smb_url_protocol">smb://</xsl:variable>

<!-- *** unc_url_protocol: unc:// *** -->
<xsl:variable name="unc_url_protocol">unc://</xsl:variable>
	
	<xsl:template match='GSP'>
    <xsl:if test="/GSP/PARAM[(@name='callback') and (@value!='')]"><xsl:value-of select="/GSP/PARAM[@name='callback']/@value"/>(</xsl:if>
    <xsl:text>{"GSP":{</xsl:text>
			"TM": "<xsl:value-of select="TM" />",
			"Q": "<xsl:value-of select="Q" />",
			"PARAM": [<xsl:apply-templates select='PARAM' />]
			<xsl:choose>
				<xsl:when test='Spelling and (count(Spelling/Suggestion) !=0)'>,
					<xsl:apply-templates select="Spelling" />
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test='ENTOBRESULTS and (count(ENTOBRESULTS/node())!=0)'>,
					<xsl:apply-templates select='ENTOBRESULTS' />
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test='GM and (count(GM) !=0)'>,
					"GM":[<xsl:apply-templates select='GM' />]
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test='RES and (count(RES/node()) != 0)'>,
					<xsl:apply-templates select='RES' />
				</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			
			
		<xsl:text>}}</xsl:text><xsl:if test="/GSP/PARAM[(@name='callback') and (@value!='')]"><xsl:text>);</xsl:text></xsl:if>
	</xsl:template>
	
	<xsl:template match="ENTOBRESULTS">
	"ENTOBRESULTS":{
		<xsl:if test="OBRES">
		"OBRES": [
			<xsl:apply-templates select="OBRES" />
		]
		</xsl:if>
	}
	</xsl:template>
	
	<xsl:template match="OBRES">
		{
			"module_name":"<xsl:value-of select='@module_name'/>",
			<xsl:if test="resultCode">"resultCode":"<xsl:value-of select='resultCode'/>",</xsl:if>
			<xsl:if test="Diagnostics">"Diagnostics":"<xsl:value-of select='Diagnostics'/>",</xsl:if>
			<xsl:if test="searchTerm">"searchTerm":"<xsl:value-of select='searchTerm'/>",</xsl:if>
			<xsl:if test="totalResults">"totalResults":"<xsl:value-of select='totalResults'/>",</xsl:if>						
			"provider":"<xsl:value-of select='provider' />",
			"title":[
				{
				"urlText":"<xsl:value-of select='title/urlText' />",
				"urlLink":"<xsl:value-of select='title/urlLink' />"
				}
			],
			<xsl:if test="IMAGE_SOURCE">"IMAGE_SOURCE":"<xsl:value-of select='IMAGE_SOURCE'/>",</xsl:if>
			"MODULE_RESULT": [
					<xsl:apply-templates select='MODULE_RESULT' />
				]
		}<xsl:if test='position() != last()'>,</xsl:if>
	</xsl:template>
	
	<xsl:template match="MODULE_RESULT">
	{
		"Title":"<xsl:value-of select='Title' />"
		<xsl:if test="U">,"U":"<xsl:value-of select='U' />"</xsl:if>
		<xsl:choose>
			<xsl:when test="Field and (count(Field/node()) != 0)">,
				"Field":[<xsl:apply-templates select="Field" />]
			</xsl:when>
		</xsl:choose>
	}<xsl:if test='position() != last()'>,</xsl:if>
	</xsl:template>
	
	<xsl:template match="Field">
	{
		"name":"<xsl:value-of select='@name' />",
		"value":"<xsl:value-of select='.' />"
	}<xsl:if test='position() != last()'>,</xsl:if>
	</xsl:template>
	
	<xsl:template match="Spelling">
		"Spelling":		
		{
			"Suggestion":[
			<xsl:for-each select="Suggestion">{
				<xsl:for-each select="@*">
					"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
					<xsl:if test="position() != last()">,
					</xsl:if>
				</xsl:for-each>
				}
				<xsl:if test="position() != last()">,
				</xsl:if>
			</xsl:for-each>
			]
		}
	</xsl:template>
	
	<xsl:template match="GM">
		{
			"GL":"<xsl:value-of select='GL'/>",
			"GD":"<xsl:value-of select='GD'/>"
		}
			<xsl:if test='position() != last()'>,
			</xsl:if>
	</xsl:template>
	
	<xsl:template match="RES">
	"RES": {
				"SN": "<xsl:value-of select="@SN" />",
				"EN": "<xsl:value-of select="@EN" />",
				"M": "<xsl:value-of select="M" />",
				<xsl:if test='R'>
				"R": [
					<xsl:apply-templates select='R' />
				]
				</xsl:if>
				<xsl:if test='PARM'>
				,<xsl:apply-templates select='PARM' />
				</xsl:if>
        }
	</xsl:template>
	
	<xsl:template match="PARAM">
	{
				<xsl:for-each select="@*">
					"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
					<xsl:if test="position() != last()">,
					</xsl:if>
				</xsl:for-each>
			}
				<xsl:if test='position() != last()'>,
				</xsl:if>
	</xsl:template>
	
    <xsl:template match='R'>
	<xsl:variable name="protocol"     select="substring-before(U, '://')"/>
	<xsl:variable name="temp_url"     select="substring-after(U, '://')"/>
	<xsl:variable name="display_url1" select="substring-after(UD, '://')"/>
	<xsl:variable name="escaped_url"  select="substring-after(UE, '://')"/>
	<xsl:variable name="display_url2">
		<xsl:choose>
			<xsl:when test="$display_url1">
				<xsl:value-of select="$display_url1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$temp_url"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="display_url">
		<xsl:choose>
			<xsl:when test="$protocol='unc'">
				<xsl:call-template name="convert_unc">
					<xsl:with-param name="string" select="$display_url2"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$display_url2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="stripped_url">
		<xsl:choose>
			<xsl:when test="$truncate_result_urls != '0'">
				<xsl:call-template name="truncate_url">
					<xsl:with-param name="t_url" select="$display_url"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$display_url"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="crowded_url" select="HN/@U"/>
	<xsl:variable name="crowded_display_url1" select="HN"/>
	<xsl:variable name="crowded_display_url">
		<xsl:choose>
			<xsl:when test="$protocol='unc'">
				<xsl:call-template name="convert_unc">
					<xsl:with-param name="string" select="substring-after($crowded_display_url1,'://')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$crowded_display_url1"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  
	<xsl:variable name="url_indexed" select="not(starts-with($temp_url, 'noindex!/'))"/>
	<xsl:variable name="apps_domain">
		<xsl:if test="starts-with($stripped_url, 'sites.google.com/a/') or
                  starts-with($stripped_url, 'docs.google.com/a/') or
                  starts-with($stripped_url, 'spreadsheets.google.com/a/')">
			<xsl:value-of select="substring-before(substring-after($stripped_url, '/a/'), '/')"/>
		</xsl:if>
	</xsl:variable>
		{
		"N":"<xsl:value-of select='@N' />",
		"DU": <xsl:choose>
			<xsl:when test="starts-with(U, $db_url_protocol)">"<xsl:value-of disable-output-escaping='yes' select="concat('db/', $temp_url)"/>"</xsl:when>
			<!-- *** URI for smb or NFS must be escaped because it appears in the URI query *** -->
			<xsl:when test="$protocol='nfs' or $protocol='smb'">"<xsl:value-of disable-output-escaping='yes' select="concat($protocol,'/',$temp_url)"/>"</xsl:when>
			<xsl:when test="$protocol='unc'">"<xsl:value-of disable-output-escaping='yes' select="concat('file://', $display_url2)"/>"</xsl:when>
			<xsl:otherwise>"<xsl:value-of disable-output-escaping='yes' select="U"/>"</xsl:otherwise>
		</xsl:choose>,
		"U":"<xsl:value-of select='U' />",
		"UE":"<xsl:value-of select='UE' />",
		"ED":"<xsl:value-of select='ED' />",
		"T":"<xsl:value-of select='T' />",
		"CRAWLDATE":"<xsl:value-of select='CRAWLDATE'/>",
		"RK":"<xsl:value-of select='RK' />",
		"FS": {	<xsl:for-each select="FS/@*">
					"<xsl:value-of select='name()' />":"<xsl:value-of select='.' />"
					<xsl:if test="position() != last()">,</xsl:if>
				</xsl:for-each>},
		"S": "<xsl:value-of select='S' />",
		"LANG": "<xsl:value-of select='LANG'/>"
		<xsl:choose>
			<xsl:when test='HAS'>
				,<xsl:apply-templates select='HAS' />
			</xsl:when>
		<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test='MT'>
			,"MT": {<xsl:apply-templates select='MT' />}
		</xsl:if>
		
		}<xsl:if test="position() != last()">,</xsl:if>
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
	
	<xsl:template match='PARM'>
	"PARM": {
				"PC": "<xsl:value-of select="PC" />"
				<xsl:if test='PMT'>
				,"PMT": [
					<xsl:apply-templates select='PMT' />
				]
				</xsl:if>
        }
	</xsl:template>

	<xsl:template match='PMT'>
		{"NM": "<xsl:value-of select='@NM' />",
		"DN": "<xsl:value-of select='@DN' />",
		"IR": "<xsl:value-of select='@IR' />",
		"T": "<xsl:value-of select='@T' />"
		<xsl:if test="PV">
		, "PV" : [ <xsl:apply-templates select='PV' />
		]}
		</xsl:if>
		<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

	<xsl:template match='PV'>
		{"V": "<xsl:value-of select='@V' />",
		"L": "<xsl:value-of select='@L' />",
		"H": "<xsl:value-of select='@H' />",
		"C": "<xsl:value-of select='@C' />"}
		<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

<!-- Match Meta tags and slot them in -->	
<xsl:template match="MT">
	"<xsl:value-of select='@N' />": "<xsl:value-of select='@V' />"<xsl:if test='position() != last()'>,</xsl:if>
</xsl:template>
	
<xsl:template name="convert_unc">
	<xsl:param name="string"/>
	<xsl:variable name="slash">/</xsl:variable>
	<xsl:variable name="backslash">\</xsl:variable>
	<xsl:variable name="escaped_ampersand">&amp;amp;</xsl:variable>
	<xsl:variable name="unescaped_ampersand">&amp;</xsl:variable>

	<xsl:variable name="converted_1">
	<xsl:call-template name="replace_string">
		<xsl:with-param name="find"    select="$slash"/>
		<xsl:with-param name="replace" select="$backslash"/>
		<xsl:with-param name="string"  select="$string"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="converted_2">
		<xsl:call-template name="decode_hex">
			<xsl:with-param name="encoded" select="$converted_1"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="converted_3">
		<xsl:call-template name="replace_string">
			<xsl:with-param name="find"    select="$escaped_ampersand"/>
			<xsl:with-param name="replace" select="$unescaped_ampersand"/>
			<xsl:with-param name="string"  select="$converted_2"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:value-of disable-output-escaping='yes' select="concat($backslash,$backslash,$converted_3)"/>
</xsl:template>

<xsl:template name="decode_hex">
	<xsl:param name="encoded" />
	<xsl:variable name="hex" select="'0123456789ABCDEF'" />
	<xsl:variable name="ascii"> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable>
	<xsl:choose>
		<xsl:when test="contains($encoded,'%')">
			<xsl:value-of select="substring-before($encoded,'%')" />
			<xsl:variable name="hexpair" select="translate(substring(substring-after($encoded,'%'),1,2),'abcdef','ABCDEF')" />
			<xsl:variable name="decimal" select="(string-length(substring-before($hex,substring($hexpair,1,1))))*16 + string-length(substring-before($hex,substring($hexpair,2,1)))" />
			<xsl:choose>
				<xsl:when test="$decimal &lt; 127 and $decimal &gt; 31">
					<xsl:value-of select="substring($ascii,$decimal - 31,1)" />
				</xsl:when>
				<xsl:when test="$decimal &gt; 159">
					<xsl:text disable-output-escaping="yes">%</xsl:text>
					<xsl:value-of select="$hexpair" />
				</xsl:when>
				<xsl:otherwise>?</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="decode_hex">
				<xsl:with-param name="encoded" select="substring(substring-after($encoded,'%'),3)" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$encoded" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="replace_string">
	<xsl:param name="find"/>
	<xsl:param name="replace"/>
	<xsl:param name="string"/>
	<xsl:choose>
		<xsl:when test="contains($string, $find)">
			<xsl:value-of select="substring-before($string, $find)"/>
			<xsl:value-of select="$replace"/>
			<xsl:call-template name="replace_string">
				<xsl:with-param name="find" select="$find"/>
				<xsl:with-param name="replace" select="$replace"/>
				<xsl:with-param name="string" select="substring-after($string, $find)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$string"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="truncate_url">
	<xsl:param name="t_url"/>
	<xsl:choose>
		<xsl:when test="string-length($t_url) &lt; $truncate_result_url_length">
			<xsl:value-of select="$t_url"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="first" select="substring-before($t_url, '/')"/>
			<xsl:variable name="last">
				<xsl:call-template name="truncate_find_last_token">
					<xsl:with-param name="t_url" select="$t_url"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="path_limit" select="$truncate_result_url_length - (string-length($first) + string-length($last) + 1)"/>
			<xsl:choose>
				<xsl:when test="$path_limit &lt;= 0">
					<xsl:value-of select="concat(substring($t_url, 1, $truncate_result_url_length), '...')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="chopped_path">
						<xsl:call-template name="truncate_chop_path">
							<xsl:with-param name="path" select="substring($t_url, string-length($first) + 2, string-length($t_url) - (string-length($first) + string-length($last) + 1))"/>
							<xsl:with-param name="path_limit" select="$path_limit"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="concat($first, '/.../', $chopped_path, $last)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="truncate_find_last_token">
	<xsl:param name="t_url"/>
	<xsl:choose>
		<xsl:when test="contains($t_url, '/')">
			<xsl:call-template name="truncate_find_last_token">
				<xsl:with-param name="t_url" select="substring-after($t_url, '/')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$t_url"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="truncate_chop_path">
	<xsl:param name="path"/>
	<xsl:param name="path_limit"/>
	<xsl:choose>
		<xsl:when test="string-length($path) &lt;= $path_limit">
			<xsl:value-of select="$path"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="truncate_chop_path">
				<xsl:with-param name="path" select="substring-after($path, '/')"/>
				<xsl:with-param name="path_limit" select="$path_limit"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
	
<xsl:template match="@*|node()"/>

</xsl:stylesheet>