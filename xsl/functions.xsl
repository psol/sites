<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:h="http://www.w3.org/1999/xhtml"
   xmlns:f="http://psol.com/2007/functions"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   version="2.0">
   <!-- 
      Copyright 2003-2013, Pineapplesoft sprl, http://www.psol.com/
      Distributed under a Creative Commons Licence: http://creativecommons.org/licenses/by-nc-sa/2.0/be/
      Authors: Benoît Marchal & Pascale Dechamps
   -->

   <xsl:function name="f:fix-href" as="xs:string">
      <xsl:param name="href" as="xs:string"/>
      <xsl:param name="context" as="xs:string"/>
      <xsl:param name="lang" as="xs:string"/>
      <xsl:variable name="result">
         <xsl:choose>
            <xsl:when test="$context = 'img'">../img/2013/<xsl:value-of select="$href"/></xsl:when>
            <xsl:when test="empty($href) and $context = 'anchor'">../<xsl:value-of select="$lang"/></xsl:when>
            <xsl:when test="$context = 'anchor'">
               <xsl:choose>
                  <xsl:when test="$href ne 'index'"><xsl:value-of select="$href"/>.html</xsl:when>
                  <xsl:otherwise>../<xsl:value-of select="$lang"/></xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:when test="$context = 'css'">../template/2013/<xsl:value-of select="$href"/></xsl:when>
            <xsl:when test="$context = 'js'">../template/2013/scripts/<xsl:value-of select="$href"/></xsl:when>
            <xsl:when test="$context = 'design'">../template/2013/images/<xsl:value-of select="$href"/></xsl:when>
            <xsl:when test="$context = 'result-document' and string-length($lang) gt 0">html/<xsl:value-of select="$lang"/>/<xsl:value-of select="$href"/>.html</xsl:when>
            <xsl:when test="$context = 'alt-document' and string-length($lang) gt 0">../<xsl:value-of select="$lang"/>/<xsl:if test="$href ne 'index'"><xsl:value-of select="$href"/>.html</xsl:if></xsl:when>
            <xsl:otherwise><xsl:message>Invalid href context</xsl:message><xsl:value-of select="$href"/></xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:value-of select="$result" separator=""/>
   </xsl:function>

   <xsl:function name="f:sanitize-id">
      <xsl:param name="id"/>
      <xsl:value-of select="translate(lower-case($id), 'îéèàùç ', 'ieeauc-')"/>           
   </xsl:function>

   <xsl:function name="f:contains" as="xs:boolean">
      <xsl:param name="haystack" as="xs:string*"/>
      <xsl:param name="needle" as="xs:string"/>
      <xsl:value-of select="exists(index-of (tokenize($haystack, ' '), $needle))"/>
   </xsl:function>

   <xsl:function name="f:article-name" as="xs:string">
      <xsl:param name="article" as="element(h:article)"/>
      <!-- this is to avoid problems when I forgot to type an @id for an article… I cannot give the same page name twice -->
      <xsl:variable name="count" select="count($article/preceding-sibling::h:article[not(@id)])" as="xs:integer"/>
      <xsl:variable name="default" select="if($count gt 0) then concat('page', xs:string($count)) else 'index'" as="xs:string"/>
      <xsl:variable name="name" select="if($article/@id) then $article/@id else $default" as="xs:string"/>
      <xsl:value-of select="f:sanitize-id($name)"/>
   </xsl:function>

   <xsl:function name="f:is-home" as="xs:boolean">
      <xsl:param name="article" as="element(h:article)"/>
      <xsl:value-of select="(not($article/@id) or $article/@id = 'index') and not($article/preceding-sibling::h:article[not(@id) or @id = 'index'])"/>
   </xsl:function>

   <xsl:function name="f:alt-exists" as="xs:boolean">
      <xsl:param name="article" as="element(h:article)"/>
      <xsl:param name="href" as="xs:string"/>
      <xsl:variable name="fname" select="concat('../xml/', $href)"/>
      <xsl:choose>
         <xsl:when test="not($article/@id) and empty($article/preceding-sibling::h:article[not(@id) or @id = 'index'])">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="string-length($article/document($fname)/h:html/h:body/h:article[@id = $article/@id]/@id) gt 0"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <xsl:function name="f:interpret-time" as="xs:integer">
      <xsl:param name="time" as="element(h:time)*"/>
      <xsl:choose>
         <xsl:when test="empty($time)">0</xsl:when>
         <xsl:otherwise><xsl:value-of select="if ($time/@datetime) then number(substring-before($time/@datetime, '-')) else number($time)"/></xsl:otherwise>
      </xsl:choose>
   </xsl:function>

</xsl:stylesheet>