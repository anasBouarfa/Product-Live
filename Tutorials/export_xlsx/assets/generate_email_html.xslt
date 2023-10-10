
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="fn"
    xmlns:pl="http://product-live.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0"
    exclude-result-prefixes="xs fn pl">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8" cdata-section-elements="" />

 <xsl:param name="destination" select="'anas.bouarfa93@gmail.com'" />
 <xsl:param name="listingUrl" select="'TESTS/listing-2023-10-03-14-13-19.xml'"/>
 <xsl:variable name="listing" select="document($listingUrl)" />
    
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <meta name="pl-mail-to" content="{$destination}" />
                <meta name="pl-mail-subject" content="Nouveau produits" />
                <meta name="pl-mail-attachments" content="images.zip=https://app.product-live.com/files-data-factory/d05a74cf11788d8f3ae9bf0e0e028dde66f0c83005c5e0d1211b0069945c0c11;pdf.zip=https://app.product-live.com/files-data-factory/fb26911d77fe9a9dc44b111eef5b5db7ca2019c8038445662f29b20c54cb6f29" />
                <style>
                    body {
                        font-family: 'Segoe UI', sans-serif;
                    }
                    b {
                        color: red;
                    }
                </style>
            </head>
            <body>
            <xsl:variable name="formatterDay" select="format-date(current-date(), '[M01]/[D01]/[Y0001]')" />
                <p>Hello <b>mail!</b></p>
                <p>
                    <xsl:value-of select="$formatterDay"/>
                    Attachments can also be <a href="{$listing/Files/File/Url}">linked</a>
                    <br/>
                    In this case, if it's a Product-Live link it will be downloaded only if the user is connected.
                </p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>