<xsl:stylesheet
    xmlns:xsl= "http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl= "http://product-live.com"
    xmlns:xs= "http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />
    
    <xsl:variable name="retrieve-days" select="1" />
    <xsl:template match="/">
        <xsl:variable name="execution-time" select="current-dateTime()" />
        <xsl:variable name="modification-date" select="$execution-time - xs:dayTimeDuration(concat('P', $retrieve-days, 'D'))" />
            <Items-Request>
                <Filters>
                    <Filter-Updated-At>
                        <Start><xsl:value-of select="$modification-date"/></Start>
                        <End><xsl:value-of select="$execution-time + xs:dayTimeDuration('P1D')"/></End>
                    </Filter-Updated-At>
                    <Filter-Conditional-Formatting key="COMPLIANCE_MODEL">
                    <Status>VALID_MODEL</Status>
                    </Filter-Conditional-Formatting>
                    <Filter-Conditional-Formatting key="COMPLIANCE_MODEL_COLOR">
                                    <Status>VALID_MODEL_COLOR</Status>
                    </Filter-Conditional-Formatting>
                    <Filter-Conditional-Formatting key="COMPLIANCE_ARTICLE">
                                    <Status>VALID_ARTICLE</Status>
                    </Filter-Conditional-Formatting>
               </Filters>
               <Properties>
                              <Identifier key="pid" />
                              <Identifier key="pcid" />
                              <Identifier key="vid" />
                              <Field key="model_name" />
                              <Classification key="categoriesSarenza" />
                              <Field key="brand" />
                              <Field key="22" />
                              <Field key="60" />
                              <Field key="size" />
                              <Field key="advised_sale_price" />
               </Properties>
            </Items-Request>
    </xsl:template>
</xsl:stylesheet>