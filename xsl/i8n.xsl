<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:f="http://psol.com/2007/functions"
   xmlns:i8n="http://psol.com/2013/i8n"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   version="2.0">
   <!-- 
      Copyright 2003-2013, Pineapplesoft sprl, http://www.psol.com/
      Distributed under a Creative Commons Licence: http://creativecommons.org/licenses/by-nc-sa/2.0/be/
      Authors: Benoît Marchal & Pascale Dechamps
   -->
   
   <xsl:variable name="i8n" select="doc('../resources/i8n.xml')/i8n:resources"/>
   
   <xsl:function name="f:localize" as="xs:string">
      <xsl:param name="id" as="xs:string"/>
      <xsl:param name="lang" as="xs:string"/>
      <xsl:variable name="string" select="$i8n/i8n:list[@xml:lang=$lang]/i8n:string[@id=$id]" as="xs:string*"/>
      <xsl:choose>
         <xsl:when test="empty($string)">
            <xsl:value-of select="concat('$$$', $id, '$$$')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$string[1]"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
   
</xsl:stylesheet>