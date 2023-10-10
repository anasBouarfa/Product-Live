<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />
    
    <xsl:template match="/">
        <Table key="PRODUCTS_SARENZA">
            <Items>
                <Item partition="976">
                    <xsl:variable name="data" select="Xlsx-To-Xml/File/Sheets/Sheet[1]/Rows/R[@i &gt; 1]" />
                    <xsl:for-each select="$data">
                        <Identifier key="pid"><xsl:value-of select="C[@j=1]"/></Identifier>
                        <Classification key="categoriesSarenza"><xsl:value-of select="C[@j=4]"/></Classification>
                        <Field key="42"><xsl:value-of select="C[@j=5]"/></Field><!--pays de fabrication-->
                        <Field key="brand"><xsl:value-of select="C[@j=6]"/></Field>
                    </xsl:for-each>
                </Item>
                <Item partition="ACTIVES">
                    <Identifier key="EAN_13">1234567890124</Identifier>
                    <Classification key="TYPOLOGY">LAPTOPS</Classification>
                    <Field key="TITLE_EN">Laptop 2</Field>
                    <Field key="DESCRIPTION_EN" delete="true"/>
                </Item>
            </Items>
        </Table>
    </xsl:template>
</xsl:stylesheet>