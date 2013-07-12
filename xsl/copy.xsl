<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:h="http://www.w3.org/1999/xhtml"
     exclude-result-prefixes="h"
     version="2.0">

<!-- this has been moved to its own stylesheet so it has lower import priority
     than imported templates (otherwise you can't really import new templates
     because this rules matches every element and it has a high priority being
     in the main stylesheet)                                                   -->

   <xsl:template match="h:*"><xsl:element name="{local-name()}"><xsl:apply-templates select="@*|node()"/></xsl:element></xsl:template>

   <xsl:template match="comment()"/>

   <xsl:template match="@*|node()" priority="-100"><xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy></xsl:template>

</xsl:stylesheet>