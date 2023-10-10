<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />
    
    <xsl:param name="language" />
    
    <xsl:template match="/">
                <Generate-Excel>
            <File>
                <File-Name>products.xlsx</File-Name>
                <Template-Key>template-tutorial</Template-Key>
                <Sheets>
                    <Sheet>
                        <Sheet-Name>products</Sheet-Name>
                        <Cells>
                            <!-- Update headers depending the language param -->
                            <xsl:choose>
                                <xsl:when test="$language='english'">
                                    <Cell-Text line="1" column="3">Title EN</Cell-Text>
                                    <Cell-Text line="1" column="4">Description EN</Cell-Text>
                                    <Cell-Text line="1" column="5">Store price</Cell-Text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <Cell-Text line="1" column="3">Title FR</Cell-Text>
                                    <Cell-Text line="1" column="4">Description FR</Cell-Text>
                                    <Cell-Text line="1" column="5">Prix magasin</Cell-Text>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:for-each select="/Table/Items/Item">
                                <!-- + 1 for headers -->
                                <xsl:variable name="position" select="position()+1" />
                                <xsl:if test="exists(Field[@key='MAIN_VIEW'])">
                                    <!-- The image is resized by the Image API with the width and height properties -->
                                    <Cell-Image line="{$position}" column="1"><xsl:value-of select="Field[@key='MAIN_VIEW']"/>?width=175&amp;height=175</Cell-Image>
                                </xsl:if>
                                <xsl:if test="exists(Identifier[@key='EAN_13'])">
                                    <Cell-Text line="{$position}" column="2"><xsl:value-of select="Identifier[@key='EAN_13']"/></Cell-Text>
                                </xsl:if>
                           <!-- Update items depending the language param -->
                                <xsl:choose>
                                    <xsl:when test="$language='english'">
                                        <xsl:if test="Field[@key='TITLE_EN'] != ''">
                                            <Cell-Text line="{$position}" column="3"><xsl:value-of select="Field[@key='TITLE_EN']"/></Cell-Text>
                                        </xsl:if>
                                        <xsl:if test="Field[@key='DESCRIPTION_EN'] != ''">
                                            <Cell-Text line="{$position}" column="4"><xsl:value-of select="Field[@key='DESCRIPTION_EN']"/></Cell-Text>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="Field[@key='TITLE_FR'] != ''">
                                            <Cell-Text line="{$position}" column="3"><xsl:value-of select="Field[@key='TITLE_FR']"/></Cell-Text>
                                        </xsl:if>
                                        <xsl:if test="Field[@key='DESCRIPTION_FR'] != ''">
                                            <Cell-Text line="{$position}" column="4"><xsl:value-of select="Field[@key='DESCRIPTION_FR']"/></Cell-Text>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>  
                                <xsl:if test="exists(Field[@key='STORE_PRICE'])">
                                    <Cell-Number line="{$position}" column="5"><xsl:value-of select="Field[@key='STORE_PRICE']"/></Cell-Number>
                                </xsl:if>                                    
                            </xsl:for-each>
                        </Cells>
                    </Sheet>
                </Sheets>
            </File>
        </Generate-Excel>
    </xsl:template>
</xsl:stylesheet>