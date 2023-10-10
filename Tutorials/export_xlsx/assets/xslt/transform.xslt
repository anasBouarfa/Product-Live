<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <!-- <xsl:output method="xml" indent="yes" encoding="UTF-8" /> -->
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />

    <xsl:param name="request_url" select="'../request.xml'" />
    <xsl:param name="table_url" select="'../TESTS/table.xml'" />

    <xsl:variable name="request" select="doc($request_url)/Items-Request/Properties" />
    <xsl:variable name="table" select="doc($table_url)/Table/Schema" />

    <xsl:param name="empty" select="''" />
    <xsl:param name="space" select="' '" />
    <xsl:param name="columnSeparator" select="';'" /> <!-- Usually ; or , -->
    <xsl:param name="textDelimiter" select="'&quot;'" /> <!-- Use &quot; for double quote: ", or use &apos; for simple quote: ' -->
    <xsl:param name="escapeCharacter" select="'&quot;'" /> <!-- It's generally the same as the encapsuler -->
    <xsl:param name="newLine" select="'&#10;'" /> <!-- Use &#10; for new line, or use &#13; for carriage return -->

    <xsl:function name="pl:clean-text">
        <xsl:param name="text" />
        <xsl:value-of select="replace($text, $textDelimiter, concat($escapeCharacter, $textDelimiter))" />
    </xsl:function>

    <xsl:template match="/">
        <!-- <xsl:copy-of select="$table"/> -->
        <xsl:variable name="generateHeader">
                <!-- En tête -->
                <xsl:for-each select="$request/Identifier">
                    <!--on récupère la clé courante -->
                    <xsl:variable name="myKey" select="@key" />
                    <Cell key="{$myKey}">
                        <xsl:value-of select="$table/Identifiers/Identifier[@key=$myKey]/Title"/>
                    </Cell>
                </xsl:for-each>
                <Cell key="created"><xsl:text>Date de création</xsl:text></Cell>
                <Cell key="categoriesSarenza"><xsl:value-of select="$table/Classifications/Classification[@key=$request/Classification/@key]/Title"/></Cell>
                <xsl:for-each select="$request/Field">
                    <!--on récupère la clé courante -->
                    <xsl:variable name="cellNumber" select="position() + 5" />
                    <xsl:variable name="myKey" select="@key" />
                    <Cell key="{$myKey}"><xsl:value-of select="$table/Fields/Field[@key=$myKey]/Title"/></Cell>
                </xsl:for-each>
        </xsl:variable>
        <xsl:message terminate="no"><xsl:copy-of select="$generateHeader"/></xsl:message>
        <!-- Lignes -->
        <xsl:variable name="data">
            <xsl:for-each select="Table/Items/Item">
                <xsl:variable name="model" select="." />
                <xsl:for-each select="Item">
                    <xsl:variable name="modelColor" select="." />
                    <xsl:for-each select="Item">
                        <xsl:variable name="modelColorSize" select="." />
                        <xsl:variable name="rowNumber" select="position() + 1"/>
                        <xsl:variable name="createdDate" select="@created" />
                            <xsl:for-each select="$generateHeader/Cell">
                                <xsl:variable name="cellNumber" select="position()"/>
                                <xsl:variable name="attribute" select="@key" />
                                <xsl:variable name="value">
                                    <xsl:choose>
                                        <!-- model -->
                                        <xsl:when test="$model/Identifier[@key=$attribute]">
                                            <xsl:value-of select="$model/Identifier[@key=$attribute]"/>
                                        </xsl:when>
                                        <xsl:when test="$model/Classification[@key=$attribute]">
                                            <xsl:value-of select="$table/Classifications/Classification[@key='categoriesSarenza']/Categories/Category[@key=$model/Classification[@key=$attribute]]/Title"/>
                                        </xsl:when>
                                        <xsl:when test="$model/Field[@key=$attribute]">
                                            <xsl:choose>
                                                <xsl:when test="count($table/Fields/Field[@key=$attribute]/Options) &gt; 0">
                                                    <xsl:variable name="optionTitle" select="$table/Fields/Field[@key=$attribute]/Options/Option[@key=$model/Field[@key=$attribute]]/Title" />
                                                    <xsl:value-of select="$optionTitle"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$model/Field[@key=$attribute]"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <!-- modelColor -->
                                        <xsl:when test="$modelColor/Identifier[@key=$attribute]">
                                            <xsl:value-of select="$modelColor/Identifier[@key=$attribute]"/>
                                        </xsl:when>
                                        <xsl:when test="$modelColor/Field[@key=$attribute]">
                                            <xsl:choose>
                                                <xsl:when test="count($table/Fields/Field[@key=$attribute]/Options) &gt; 0">
                                                    <xsl:variable name="optionTitle" select="$table/Fields/Field[@key=$attribute]/Options/Option[@key=$modelColor/Field[@key=$attribute]]/Title" />
                                                    <xsl:value-of select="$optionTitle"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$modelColor/Field[@key=$attribute]"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <!-- modelColorSize -->
                                        <xsl:when test="$modelColorSize/Identifier[@key=$attribute]">
                                            <xsl:value-of select="$modelColorSize/Identifier[@key=$attribute]"/>
                                        </xsl:when>
                                        <xsl:when test="$modelColorSize/Field[@key=$attribute]">
                                            <xsl:choose>
                                                <xsl:when test="count($table/Fields/Field[@key=$attribute]/Options) &gt; 0">
                                                    <xsl:variable name="optionTitle" select="$table/Fields/Field[@key=$attribute]/Options/Option[@key=$modelColorSize/Field[@key=$attribute]]/Title" />
                                                    <xsl:value-of select="$optionTitle"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="$modelColorSize/Field[@key=$attribute]"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:when test="@key='created'">
                                            <xsl:value-of select="format-dateTime($modelColorSize/@created, '[D01]/[M01]/[Y0001]')"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:variable>
                                <Cell-Text line="{$rowNumber}" column="{$cellNumber}"><xsl:value-of select="$value" /></Cell-Text>
                            </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <!-- <xsl:copy-of select="$generateHeader"/> -->
        <!-- <xsl:copy-of select="$data"/> -->
        <xsl:message terminate="no"><xsl:copy-of select="$data"/></xsl:message>
        <Generate-Excel>
            <File>
                <File-Name>products.xlsx</File-Name>
                <Template-Key>products</Template-Key>
                    <Sheets>
                        <Sheet>
                            <Sheet-Name>products</Sheet-Name>
                            <Cells>
                                <xsl:for-each select="$generateHeader/Cell">
                                    <xsl:variable name="pos" select="position()"/>
                                    <Cell-Text line="1" column="{$pos}"><xsl:value-of select="."/></Cell-Text>
                                </xsl:for-each>
                                <xsl:copy-of select="$data"/>
                            </Cells>
                        </Sheet>
                    </Sheets>
            </File>
        </Generate-Excel>
    </xsl:template>
</xsl:stylesheet>