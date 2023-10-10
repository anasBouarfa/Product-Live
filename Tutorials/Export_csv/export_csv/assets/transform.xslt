<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="text" encoding="UTF-8" />
    <xsl:strip-space elements="*" />

    <xsl:param name="columnSeparator" select="';'" /> <!-- Usually ; or , -->
    <xsl:param name="textDelimiter" select="'&quot;'" /> <!-- Use &quot; for double quote: ", or use &apos; for simple quote: ' -->
    <xsl:param name="escapeCharacter" select="'&quot;'" /> <!-- It's generally the same as the encapsuler -->
    <xsl:param name="newLine" select="'&#10;'" /> <!-- Use &#10; for new line, or use &#13; for carriage return -->
    
    <xsl:param name="tableUrl" select="'TESTS/table.xml'" />
    <xsl:variable name="table" select="doc($tableUrl)/Table/Schema"/>

    <!-- This function is used to escape the textDelimiter from the input text -->
    <xsl:function name="pl:clean-text">
        <xsl:param name="text" />
        <xsl:value-of select="replace($text, $textDelimiter, concat($escapeCharacter, $textDelimiter))" />
    </xsl:function>
    
    <xsl:template match="/">
        <!-- Headers -->
        <!-- For each header -->
        <xsl:value-of select="$textDelimiter" />
        <xsl:text>PID</xsl:text>
        <xsl:value-of select="$textDelimiter"/>
        <xsl:value-of select="$columnSeparator"/>

        <xsl:value-of select="$textDelimiter" />
        <xsl:text>PCID</xsl:text>
        <xsl:value-of select="$textDelimiter"/>
        <xsl:value-of select="$columnSeparator"/>

        <xsl:value-of select="$textDelimiter" />
        <xsl:text>VID</xsl:text>
        <xsl:value-of select="$textDelimiter"/>
        <xsl:value-of select="$columnSeparator"/>

        <xsl:value-of select="$textDelimiter" />
        <xsl:text>Catégorisation Achat</xsl:text>
        <xsl:value-of select="$textDelimiter"/>
        <xsl:value-of select="$columnSeparator"/>

        <xsl:value-of select="$textDelimiter" />
        <xsl:text>Marque</xsl:text>
        <xsl:value-of select="$textDelimiter"/>
        <xsl:value-of select="$columnSeparator"/>

        <!-- Do not forget the newLine character ! -->
        <xsl:value-of select="$newLine"/>

        <xsl:for-each select="/Table/Items/Item">
            <!-- For each value that must be exported -->
            <xsl:value-of select="$textDelimiter" />
            <xsl:value-of select="pl:clean-text(Identifier[@key='pid'])"/>
            <xsl:value-of select="$textDelimiter"/>
            <xsl:value-of select="$columnSeparator"/>
            
            <xsl:value-of select="$textDelimiter" />*
            <xsl:value-of select="pl:clean-text(Identifier[@key='pcid'])"/>
            <xsl:value-of select="$textDelimiter"/>
            <xsl:value-of select="$columnSeparator"/>

            <xsl:value-of select="$textDelimiter" />
            <xsl:value-of select="pl:clean-text(Identifier[@key='vid'])"/>
            <xsl:value-of select="$textDelimiter"/>
            <xsl:value-of select="$columnSeparator"/>

            <xsl:value-of select="$textDelimiter" />
            <xsl:variable name="codeCategory" select="pl:clean-text(Classification[@key='categoriesSarenza'])" />
            <xsl:value-of select="$table/Classifications/Classification/Categories/Category[@key=$codeCategory]/Title"/>
            <xsl:value-of select="$textDelimiter"/>
            <xsl:value-of select="$columnSeparator"/>

            <xsl:value-of select="$textDelimiter" />
            <xsl:variable name="brand" select="pl:clean-text(Field[@key='brand'])" />
            <xsl:value-of select="$table/Fields/Field[@key='brand']/Options/Option[@key=$brand]/Title"/>
            <xsl:value-of select="$textDelimiter"/>
            <xsl:value-of select="$columnSeparator"/>

            <!-- Do not forget the newLine character ! -->
            <xsl:value-of select="$newLine"/>
        </xsl:for-each>        
    </xsl:template>
</xsl:stylesheet>