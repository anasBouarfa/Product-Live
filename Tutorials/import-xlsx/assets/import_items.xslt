<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />

    <xsl:param name="table_url" select="'TESTS/table.xml'" />
    <xsl:variable name="table" select="doc($table_url)/Table/Schema" />
    
    <xsl:template match="/">
        <Table key="PRODUCTS_SARENZA">
            <Items>
                <Item partition="976">
                    <xsl:variable name="data" select="Xlsx-To-Xml/File/Sheets/Sheet[1]/Rows/R[@i &gt; 1]" />
                    <xsl:for-each-group select="$data" group-by="C[@j=1]">
                        <Identifier key="pid"><xsl:value-of select="current-grouping-key()"/></Identifier>
                        
                        <Classification key="categoriesSarenza">
                            <xsl:variable name="value" select="C[@j=4]"/>
                            <xsl:value-of select="$table/Classifications/Classification[@key='categoriesSarenza']/Categories/Category[Title=$value]/@key"/>
                        </Classification>
                        
                        <Field key="42">
                            <xsl:variable name="value" select="C[@j=5]" />
                            <xsl:value-of select="$table/Fields/Field[@key='42']/Options/Option[Title=$value]/@key"/>
                        </Field><!--pays de fabrication-->
                        <Field key="brand">
                            <xsl:variable name="value" select="C[@j=6]" />
                            <xsl:value-of select="$table/Fields/Field[@key='brand']/Options/Option[Title=$value]/@key"/>
                        </Field>

                        <xsl:for-each-group select="current-group()" group-by="C[@j=2]">
                            <Item>
                                <Identifier key="pcid"><xsl:value-of select="current-grouping-key()"/></Identifier>
                                <Field key="174">                            
                                    <xsl:variable name="value" select="C[@j=7]" />
                                    <xsl:value-of select="$table/Fields/Field[@key='174']/Options/Option[Title=$value]/@key"/>
                                </Field>

                                <xsl:for-each select="current-group()">
                                    <Item>
                                        <Identifier key="vid"><xsl:value-of select="C[@j=3]"/></Identifier>
                                        <Field key="advised_sale_price"><xsl:value-of select="C[@j=11]"/></Field>
                                    </Item>
                                </xsl:for-each>
                            </Item>
                        </xsl:for-each-group>
                    </xsl:for-each-group>
                </Item>
            </Items>
        </Table>
    </xsl:template>
</xsl:stylesheet>