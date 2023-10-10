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
            <xsl:variable name="categories" select="Csv-To-Xml/File/Rows/R[@i&gt; 1]" />
            <Title>Produits</Title>
            <Title-Local lang="fra">Produits</Title-Local>
            <Color>RED</Color>
            <Position>1</Position>
            <Schema>
                <Classifications key="categoriesSarenza">
                    <Title>Catégorisation achat</Title>
                    <Categories>
                        <xsl:for-each-group select="$categories" group-by="C[@j=1]">
                            <Category key="{C[@j=1]}">
                                <Title><xsl:value-of select="C[@j=2]"/></Title>
                            </Category>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="$categories" group-by="C[@j=3]">
                            <xsl:variable name="C2" select="C[@j=3]" />
                                <xsl:if test="not(string($C2)='')">
                                <Category key="{C[@j=3]}" parent="{C[@j=1]}">
                                    <Title><xsl:value-of select="C[@j=4]"/></Title>
                                </Category>
                                </xsl:if>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="$categories" group-by="C[@j=5]">
                            <xsl:variable name="C3" select="C[@j=5]" />
                            <xsl:if test="not(string($C3)='')">
                                <Category key="{C[@j=5]}" parent="{C[@j=3]}">
                                    <Title><xsl:value-of select="C[@j=6]"/></Title>
                                </Category>
                            </xsl:if>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="$categories" group-by="C[@j=7]">
                                    <Category key="{C[@j=7]}" parent="{C[@j=5]}">
                                        <Title><xsl:value-of select="C[@j=8]"/></Title>
                                    </Category>
                        </xsl:for-each-group>
                    </Categories>
                </Classifications>
            </Schema>
        </Table>
    </xsl:template>
</xsl:stylesheet>