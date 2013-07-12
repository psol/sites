<?xml version="1.0" encoding="UTF-8"?>
<schema
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron"
   queryBinding="xslt2">
   <!-- 
      Copyright 2003-2013, Pineapplesoft sprl, http://www.psol.com/
      Distributed under a Creative Commons Licence: http://creativecommons.org/licenses/by-nc-sa/2.0/be/
      Author: Benoît Marchal
   -->

   <xsl:include href="../xsl/functions.xsl"/>

   <ns uri="http://www.w3.org/1999/xhtml" prefix="h"/>
   <ns uri="http://psol.com/2007/functions" prefix="f"/>      

   <pattern>
      <rule context="h:html">
         <assert test="@lang">Language attribute is required.</assert>
      </rule>
      
      <rule context="h:body">
         <assert test="count(h:article[not(@id)]) lt 2" role="warning">Some articles will have default filenames.</assert>
      </rule>

      <rule context="h:body/h:article">
         <assert test="@title">Top-level articles need title attributes for head/title</assert>
         <assert test="count(h:h1) eq 1">Top-level articles need one and only one h1 title</assert>
         <assert test="count(h:article) eq 0">Articles in articles are not supported, consider sections instead.</assert>
      </rule>

      <rule context="h:section[@class='qualifications']/h:div">
         <assert test="count(h:time) lt 3">There cannot be more than two dates in qualification list.</assert>
         <assert test="count(h:time) eq 1 or (h:time[@class='start'] and h:time[@class='end'])">If there is more than a date, they must form a period (start/end).</assert>
         <assert test="count(h:time) lt 2 or (number(h:time[@class='start']) lt number(h:time[@class='end']))">Dates must be coherent: end before start</assert>
      </rule>

   </pattern>

   <pattern>
      <rule context="h:article[f:contains(@class, 'cv')]">
         <assert test="*[f:contains(@class, 'fn')]">Full name is required in CV.</assert>
         <assert test="*[f:contains(@class, 'role')]">Role is required in CV.</assert>
         <assert test="*[f:contains(@class, 'description')]">Description is required in CV.</assert>
         <assert test="h:img[f:contains(@class, 'photo')]/@src">Photo is required in CV.</assert>
      </rule>

      <rule context="h:article[f:contains(@class, 'cv')]/h:section[f:contains(@class, 'qualifications')]">
         <assert test="(h:div/h:span[f:contains(@class, 'action') or f:contains(@class, 'result')]) and empty(h:div/h:span[@class, 'goal'])">You cannot mix goals and action/result in a CV section.</assert>
      </rule>
   </pattern>

</schema>