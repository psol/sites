<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:h="http://www.w3.org/1999/xhtml"
   xmlns:f="http://psol.com/2007/functions"
   exclude-result-prefixes="h f xs"
   version="2.0">
   <!-- 
      Copyright 2003-2013, Pineapplesoft sprl, http://www.psol.com/
      Distributed under a Creative Commons Licence: http://creativecommons.org/licenses/by-nc-sa/2.0/be/
      Authors: Benoît Marchal & Pascale Dechamps
   -->

   <xsl:output method="html" encoding="ISO-8859-1"/>

   <xsl:include href="copy.xsl"/>
   <xsl:include href="functions.xsl"/>
   <xsl:include href="i8n.xsl"/>

   <xsl:variable name="lang" select="/h:html/@lang"/>

   <xsl:template match="/">
      <html>
         <head>
            <title>Processing report</title>
         </head>
         <body>
            <h1>Processing report</h1>
            <p>I have published the following files:</p>
            <ul>
               <xsl:for-each select="h:html/h:body/h:article">
                  <li><a href="html/{$lang}/{f:fix-href(f:article-name(.), 'anchor')}"><xsl:value-of select="if(string-length(@title) lt 1) then '...' else @title"/></a></li>
               </xsl:for-each>
            </ul>
         </body>
      </html>
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="h:html | h:body">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="h:body/h:article">
      <!-- REFACTOR: need to move the name generation completely in fix-href with, say document context -->
      <xsl:result-document href="{f:fix-href(concat('html/', $lang, '/', f:article-name(.)), 'anchor')}">
         <!-- very much a hack but xsl:output does not like it when I try to specify a doctype without public or system id… -->
         <xsl:text disable-output-escaping='yes'><![CDATA[<!DOCTYPE html>]]>
</xsl:text>
         <xsl:variable name="alt-exists" select="f:alt-exists(., $lang)" as="xs:boolean"/>
         <html lang="{$lang}">
            <xsl:apply-templates select="." mode="head"/>
            <body class="home page page-id-2 page-template page-template-template-home-php boxed safari">
               <div id="wrapper">
                  <xsl:apply-templates select="." mode="header">
                     <xsl:with-param name="alt-exists" select="$alt-exists" tunnel="yes"/>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="h:ul[f:contains(@class, 'slider')]" mode="slider"/>
                  <xsl:apply-templates select="." mode="body"/>
                  <xsl:apply-templates select="." mode="footer"/>
               </div>
               <xsl:apply-templates select="." mode="scripts"/>
            </body>   
         </html>
      </xsl:result-document>
   </xsl:template>

   <xsl:template match="h:article" mode="head">
      <head>            
         <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
         <title><xsl:value-of select="@title"/></title>
         <!--            <meta name="description" content="<?php bloginfo('description'); ?>">
            <meta name="author" content="Adrian Diaconescu">-->
         <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width"/>
         <link rel="shortcut icon" href="/favicon.ico"/>
         <link rel="stylesheet" type="text/css" href="{f:fix-href('style.css', 'css')}"/>
         <link rel="stylesheet" type="text/css" href="{f:fix-href('responsive.css', 'css')}"/>
         <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,300italic,400italic,600italic,700italic|Noticia+Text|Lato:400,700" />
         <xsl:text disable-output-escaping='yes'><![CDATA[
<!--[if IE]>
<script src="]]></xsl:text>
<xsl:value-of select="f:fix-href('html5.js', 'js')"/>
<xsl:text disable-output-escaping="yes"><![CDATA["></script>
<![endif]-->
]]>
</xsl:text>
         <script type="text/javascript" src="{f:fix-href('twitter.js', 'js')}"></script>
         <script type="text/javascript" src="{f:fix-href('jquery.js', 'js')}"></script>
         <script type="text/javascript" src="{f:fix-href('mediaqueries.js', 'js')}"></script>                                        
      </head>
   </xsl:template>

   <xsl:template match="h:article" mode="header">
      <xsl:param name="alt-exists" tunnel="yes" select="false()" as="xs:boolean"/>
      <header id="mainheader">
         <div class="container">
            <div id="mainheader-links">
               <nav>
                  <ul id="menu-header-links" class="menu">
                     <xsl:if test="$alt-exists">
                        <li id="menu-item-{generate-id()}" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-{generate-id()}"><a href="{f:fix-href(f:article-name(.), 'alt-document', $lang)}"><xsl:value-of select="f:localize('altLang', $lang)"/></a></li>
                     </xsl:if>
                     <li id="menu-item-{generate-id()}" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-{generate-id()}"><a href="{f:fix-href('contact', 'anchor')}"><xsl:value-of select="f:localize('askUs', $lang)"/></a></li>
                  </ul>
               </nav>
               <p><strong><xsl:value-of select="f:localize('callUs', $lang)"/></strong> + 32 81 226 270 / <strong><xsl:value-of select="f:localize('twitter', $lang)"/></strong><a href="http://twitter.com/declencheur">@declencheur</a></p>
            </div>
            <div id="logo">				
               <hgroup>
                  <h1><a href="{f:fix-href('index', 'anchor')}"><img src="{f:fix-href('pineapplesoft-small.png', 'img')}" alt="Pineapplesoft"/></a></h1>
               </hgroup>	
            </div>
         </div>	
         <div id="mainmenu">
            <div class="container">
               <div id="togglemenu"><a href="#"><xsl:value-of select="f:localize('browse', $lang)"/></a></div>
               <nav>
                  <ul id="menu-main-menu" class="sf-menu">
                     <xsl:variable name="self" select="." as="element()"/>
                     <xsl:for-each select="../h:article[@data-menu]">
                        <li class="menu-item menu-item-type-post_type menu-item-object-page{if (. = $self) then ' current-menu-item page-item-2 current_page_item' else ''}"><a href="{f:fix-href(f:article-name(.), 'anchor')}"><xsl:value-of select="@data-menu"/></a></li>
                     </xsl:for-each>
                  </ul>
                  <form method="get" id="searchbox" action="http://www.google.com/search" role="search">
                     <input type="text" class="field" name="s" id="s" placeholder="Recherche &#8230;" />
                     <input name="sitesearch" type="hidden" value="www.psol.be"/>
                     <input type="hidden" id="searchsubmit" />
                  </form>
               </nav>				
            </div>
         </div>
      </header>
   </xsl:template>

   <xsl:template match="h:article" mode="footer">
      <footer id="mainfooter">
         <div class="container">
            <section class="row">
               <div id="postlist-4" class="column fourcol widget widget_postlist">
                  <h3 class="widget-title"><xsl:value-of select="f:localize('consultants', $lang)"/></h3>	
                  <div class="postlist">			
                     <ul>
                        <xsl:for-each select="../h:article[f:contains(@class, 'cv')]">
                           <li><a href="{f:fix-href(f:sanitize-id(@id), 'anchor')}"><xsl:value-of select="h:h1"/></a></li>
                        </xsl:for-each>
                     </ul>			
                  </div>
               </div>
               <div id="tweets-2" class="column fourcol widget widget_tweets">
                  <h3 class="widget-title">Derniers Tweets</h3>
                  <div class="tweetlist" id="tweetlist_66">
                     <ul>
                        <li>Loading tweets ...</li>
                     </ul>	
                  </div>
                  <script type="text/javascript">
                     jQuery(document).ready(function($){
                     $.getJSON('http://api.twitter.com/1/statuses/user_timeline/declencheur.json?count=2',
                     function(tweets) {
                     $("#tweetlist_66 ul").html(twitterCallback2(tweets));
                     });
                     });
                  </script>
                  <p><a href="http://twitter.com/declencheur" class="morelink"><xsl:value-of select="f:localize('followUs', $lang)"/></a></p></div>
               <div id="text-2" class="column fourcol widget widget_text">
                  <h3 class="widget-title"><xsl:value-of select="f:localize('contactUs', $lang)"/></h3>			
                  <div class="textwidget">
                     <p><xsl:value-of select="f:localize('postalAddress', $lang)" disable-output-escaping="yes"/></p>
                     <p><xsl:value-of select="f:localize('phone', $lang)"/></p>
                     <p><a href="{f:fix-href('contact', 'anchor')}"><xsl:value-of select="f:localize('email', $lang)"/></a></p>
                  </div>
               </div>
            </section>
            <div id="mainfooter-links">
               <p>Mise à jour : <xsl:value-of select="format-date(current-date(), '[MNn]', 'fr', (), ())"/><xsl:text> </xsl:text><xsl:value-of select="format-date(current-date(), '[Y]')"/></p>
               <p>&#169; 1995 - <xsl:value-of select="format-date(current-date(), '[Y]')"/>, Pineapplesoft sprl. <xsl:value-of select="f:localize('rightsReserved', $lang)"/></p>
               <!--
                  <nav>
                        <ul id="menu-footer-links" class="menu"><li id="menu-item-1862" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1862"><a href="#">Terms &#038; Conditions</a></li>
                            <li id="menu-item-1863" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1863"><a href="#">Privacy Policy</a></li>
                            <li id="menu-item-1864" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-1864"><a href="#">Contact Us</a></li>
                        </ul>
                  </nav>
               -->
            </div>
         </div>
      </footer>
   </xsl:template>

   <xsl:template match="h:article" mode="scripts">
      <script type="text/javascript" src="{f:fix-href('jquery.ui.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.superfish.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.supersubs.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.flexslider.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.roundabout.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.caroufredsel.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.fancybox.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.imagesloaded.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.isotope.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.fitvids.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('jquery.tiptip.js', 'js')}"></script>
      <script type="text/javascript" src="{f:fix-href('theme.js', 'js')}"></script>
   </xsl:template>

   <xsl:template match="h:article[f:is-home(.)]" mode="body">
      <div class="container home-widgets">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <xsl:template match="h:article" mode="body" priority="-100">
      <div class="container">
         <div class="row">
            <div id="content" class="column twelvecol">
               <article id="post-{generate-id()}" class="post-{generate-id()} page type-page status-publish hentry">
                  <xsl:apply-templates/>
               </article>
            </div>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="h:article[count(h:section) eq 0]" mode="body" priority="-90">
      <div class="container">
         <div class="row">
            <div id="content" class="column twelvecol">
               <article id="post-{generate-id()}" class="post-{generate-id()} page type-page status-publish hentry">
                  <xsl:apply-templates select="h:h1"/>
                  <div class="entry-content">
                     <xsl:apply-templates select="node()[not(self::h:h1)]"/>
                  </div>
               </article>
            </div>
         </div>
      </div>
   </xsl:template>
   
   <xsl:template match="h:section">
      <section class="row widgets">
         <div id="question-{count(preceding-sibling::h:section) + 2}" class="column twelvecol widget widget_text">
            <xsl:apply-templates/>
         </div>
      </section>
   </xsl:template>
   
   <xsl:template match="h:div[f:contains(@class, 'related')]">
      <div class="row">
         <xsl:apply-templates mode="related"/>
      </div>
   </xsl:template>

   <xsl:template match="h:span[f:contains(@class, 'label')] | h:div[f:contains(@class, 'label')]" mode="related">
      <div class="column twocol" style="margin-bottom: 5px;">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <xsl:template match="h:span | h:div" mode="related">
      <div class="column sixcol" style="margin-bottom: 5px;">
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <xsl:template match="h:section[f:contains(@class, 'list-cv')]">
      <div class="entry-content">
         <p></p>
         <div class="snippets snippets-person list list isotope">
            <xsl:for-each select="../../h:article[f:contains(@class, 'cv')]">
               <xsl:variable name="href" select="f:fix-href(f:article-name(.) , 'anchor')"/>
               <xsl:variable name="name" select="*[f:contains(@class, 'fn')]"/>
               <div class="board-of-directors shareholders snippet isotope-item">
                  <div class="column twocol">
                     <div class="imgholder">
                        <div><img src="{f:fix-href(h:img[f:contains(@class, 'photo')]/@src, 'img')}" class="attachment-page-thumb wp-post-image"
                           alt="{$name}"/><a href="{$href}" class="imghover"><xsl:value-of select="f:localize('viewLarge', $lang)"></xsl:value-of></a></div>
                     </div>
                  </div>
                  <div class="column sevencol">
                     <h3><a href="{$href}"><xsl:value-of select="$name"/></a></h3>
                     <h4><xsl:value-of select="*[f:contains(@class, 'role')]"/></h4>
                     <p><xsl:value-of select="*[f:contains(@class, 'description')]"></xsl:value-of></p>
                  </div>
               </div>
            </xsl:for-each>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="h:section[f:contains(@class, 'highlights')]">
      <section class="row widgets"><xsl:apply-templates/></section>
   </xsl:template>

   <xsl:template match="h:section[f:contains(@class, 'highlights')]/h:div">
      <div id="intro-{count(preceding-sibling::h:div) + 2}" class="column fourcol widget widget_intro">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <xsl:template match="h:section[f:contains(@class, 'highlights')]/h:div/h:h2">
      <span class="icon"><xsl:apply-templates select="." mode="icon"/></span><h3 class="widget-title"><xsl:apply-templates/></h3>
   </xsl:template>

   <xsl:template match="h:h2[@data-icon = 'motivating']" mode="icon">8</xsl:template>
   <xsl:template match="h:h2[@data-icon = 'organized']" mode="icon">$</xsl:template>
   <xsl:template match="h:h2[@data-icon = 'rewarding']" mode="icon">B</xsl:template>
   <xsl:template match="h:h2" mode="icon">1</xsl:template>
   
   <xsl:template match="h:article[f:is-home(.)]/h:h1"/>

   <xsl:template match="h:h1">
      <header>
         <h1 class="entry-title"><xsl:apply-templates/></h1>
      </header>
   </xsl:template>

   <xsl:template match="h:ul[f:contains(@class, 'slider')]"/>

   <xsl:template match="h:ul[f:contains(@class, 'slider')]" mode="slider">
      <div class="home-slider background" id="slider-flexslider">
         <div class="container">
            <div class="row">
               <div class="flexslider">
                  <ul class="slides">
                     <xsl:apply-templates/>
                  </ul>
                  <div class="flex-nav"></div>
               </div>
            </div>
         </div></div>
   </xsl:template>
   
   <xsl:template match="h:ul[f:contains(@class, 'slider')]/h:li">
      <li>
         <div class="column twelvecol">
            <div class="imgholder">
               <div>
                  <xsl:apply-templates/>
               </div>
            </div>
         </div>
      </li>
   </xsl:template>

   <xsl:template match="h:ul[f:contains(@class, 'slider')]/h:li/h:img">
      <img class="attachment-slide-image wp-post-image">
         <xsl:apply-templates select="@*"/>
      </img>
   </xsl:template>

   <xsl:template match="h:a/@href">
      <xsl:attribute name="href" select="f:fix-href(., 'anchor')"/>
   </xsl:template>

   <xsl:template match="h:img/@src">
      <xsl:attribute name="src" select="f:fix-href(., 'img')"/>
   </xsl:template>

   <xsl:template match="h:article[f:contains(@class, 'cv')]" mode="body">
      <div class="container">
         <div class="row">
            <div id="content" class="column ninecol">
               <article id="post-{position()}" class="post-{position()} person type-person status-publish hentry">
                  <header>
                     <h1 class="entry-tile"><xsl:value-of select="*[@class='fn']"/></h1>
                  </header>
                  <div class="entry-content">
                     <div class="entry-data">
                        <div class="row">
                           <div class="column twocol"><strong><xsl:value-of select="f:localize('positionCV', $lang)"/></strong></div>
                           <div class="column sevencol"><xsl:value-of select="*[f:contains(@class, 'role')]"/></div>
                        </div>
                        <div class="row">
                           <div class="column twocol"><strong><xsl:value-of select="f:localize('contactCV', $lang)"/></strong></div>
                           <div class="column sevencol social">
                              <a href="{f:fix-href('contact', 'anchor')}"><img src="{f:fix-href('ico_email.png', 'design')}"/></a>
                              <xsl:apply-templates select="h:a[@rel='linkedin']" mode="social"/>
                              <xsl:apply-templates select="h:a[@rel='facebook']" mode="social"/>
                              <xsl:apply-templates select="h:a[@rel='twitter']" mode="social"/>
                           </div>
                        </div>
                        <xsl:apply-templates select="h:ul[f:contains(@class, 'callout')]" mode="cv-callout"/>
                        <xsl:apply-templates select="h:section[f:contains(@class, 'qualifications')]" mode="cv-qualifications"/>
                     </div>
                  </div>
               </article>
            </div>
            <aside id="sidebar" class="column threecol">
               <nav id="sidemenu">
                  <h3 class="widget-title"><xsl:value-of select="f:localize('consultantsCV', $lang)"/></h3>
                  <ul>
                     <xsl:variable name="self" select="."/>
                     <xsl:for-each select="../h:article[f:contains(@class, 'cv')]">
                        <li>
                           <xsl:choose>
                              <xsl:when test=". = $self">
                                 <xsl:attribute name="class">current_page_item</xsl:attribute>
                                 <xsl:value-of select="*[f:contains(@class, 'fn')]"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <a href="{f:fix-href(f:article-name(.), 'anchor')}"><xsl:value-of select="*[f:contains(@class, 'fn')]"/></a>
                              </xsl:otherwise>
                           </xsl:choose>
                        </li>
                     </xsl:for-each>
                     <!--
                  <li class="current_page_item"><span>Pascale Dechamps</span></li>
                  <li><a href="benoit-marchal.html">Benoît Marchal</a></li>
                  -->
                  </ul>
               </nav>
               <div class="imgholder">
                  <div><img src="{f:fix-href(h:img[f:contains(@class, 'photo')]/@src, 'img')}" class="attachment-page-thumb wp-post-image" alt="{*[f:contains(@class, 'fn')]}"/></div>
               </div>
            </aside>
         </div>
      </div>
   </xsl:template>

   <xsl:template match="h:ul" mode="cv-callout">
      <h2><xsl:value-of select="@title"/></h2>
      <ul>
         <xsl:apply-templates select="h:li"/>
      </ul>
   </xsl:template>

   <xsl:template match="h:section" mode="cv-qualifications">
      <h2><xsl:value-of select="h:h2"/></h2>
      <xsl:apply-templates select="h:div" mode="cv-qualifications"/>
   </xsl:template>

   <xsl:template match="h:div[h:time]" mode="cv-qualifications" priority="-50">
      <p><xsl:apply-templates select="." mode="cv-qualifications-time"/> — <xsl:value-of select="h:span"/></p>
   </xsl:template>

   <xsl:template match="h:div" mode="cv-qualifications" priority="-80">
      <xsl:variable name="bullet" select="*"/>
      <xsl:choose>
         <xsl:when test="count($bullet) eq 1"><p><xsl:value-of select="$bullet"/></p></xsl:when>
         <xsl:otherwise>
            <ul><xsl:for-each select="$bullet"><li><xsl:value-of select="."/></li></xsl:for-each></ul>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="h:div[*[f:contains(@class, 'action')]]" mode="cv-qualifications">
      <h3><xsl:apply-templates select="." mode="cv-qualifications-time"/> — <xsl:value-of select="*[f:contains(@class, 'org')]"/></h3>
      <table cellspacing="0" cellpadding="0">
         <xsl:if test="position() mod 2 eq 0">
            <xsl:attribute name="class">odd</xsl:attribute>
         </xsl:if>
         <tbody>
            <tr>
               <th width="50%"><xsl:value-of select="f:localize('actionCV', $lang)"/></th>
               <th width="50%"><xsl:value-of select="f:localize('resultCV', $lang)"/></th>
            </tr>
            <tr>
               <xsl:variable name="action" select="*[f:contains(@class, 'action')]"/>
               <xsl:variable name="result" select="*[f:contains(@class, 'result')]"/>
               <td>
                  <xsl:choose>
                     <xsl:when test="count($action) eq 1"><xsl:value-of select="$action"/></xsl:when>
                     <xsl:otherwise>
                        <ul><xsl:for-each select="$action"><li><xsl:value-of select="."/></li></xsl:for-each></ul>
                     </xsl:otherwise>
                  </xsl:choose>
               </td>
               <td>
                  <xsl:choose>
                     <xsl:when test="count($result) eq 1"><xsl:value-of select="$result"/></xsl:when>
                     <xsl:otherwise>
                        <ul><xsl:for-each select="$result"><li><xsl:value-of select="."/></li></xsl:for-each></ul>
                     </xsl:otherwise>
                  </xsl:choose>
               </td>
            </tr>
         </tbody>
      </table>
   </xsl:template>

   <xsl:template match="h:div[*[f:contains(@class, 'goal')]]" mode="cv-qualifications">
      <h3><xsl:apply-templates select="." mode="cv-qualifications-time"/> — <xsl:value-of select="*[f:contains(@class, 'org')]"/><xsl:apply-templates
         select="*[f:contains(@class, 'org-note')]" mode="cv-qualification-note"/></h3>
      <xsl:variable name="goal" select="*[f:contains(@class, 'goal')]"/>
      <xsl:choose>
         <xsl:when test="count($goal) eq 1"><p><xsl:value-of select="$goal"/></p></xsl:when>
         <xsl:otherwise>
            <ul><xsl:for-each select="$goal"><li><xsl:value-of select="."/></li></xsl:for-each></ul>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="h:div | h:span" mode="cv-qualification-note">
      <br/><i style="font-size: small;"><xsl:apply-templates/></i>
   </xsl:template>
   
   <xsl:template match="h:div" mode="cv-qualifications-time">
      <xsl:choose>
         <xsl:when test="count(h:time) eq 1"><xsl:value-of select="h:time"/></xsl:when>
         <xsl:when test="count(h:time) eq 2"><xsl:value-of select="h:time[@class='start']"/><xsl:text> - </xsl:text><xsl:value-of select="h:time[@class='end']"/></xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="h:a[@rel='linkedin']" mode="social">
      <a href="{@href}"><img src="{f:fix-href('ico_linkedin.png', 'design')}"/></a>
   </xsl:template>

   <xsl:template match="h:a[@rel='facebook']" mode="social">
      <a href="{@href}"><img src="{f:fix-href('ico_facebook.png', 'design')}"/></a>
   </xsl:template>

   <xsl:template match="h:form">
      <div class="wpcf7" id="wpcf7-{generate-id()}">
         <form action="/cgi-sys/cgiemail/contact2.txt" method="post" class="wpcf7-form">
            <div style="display: none;"><input value="{f:fix-href('success', 'anchor')}" name="success" type="hidden"/></div>
            <xsl:apply-templates/>
            <div class="wpcf7-response-output wpcf7-display-none"></div>
         </form>
      </div>
   </xsl:template>

   <xsl:template match="h:input">
      <p><xsl:value-of select="@title"/><br/><span class="wpcf7-form-control-wrap your-{@name}"><input type="text" name="{@name}" class="wpcf7-form-control wpcf7-text" size="40"/></span></p>
   </xsl:template>

   <xsl:template match="h:input[f:contains(@class, 'email')]">
      <p><xsl:value-of select="@title"/><br/><span class="wpcf7-form-control-wrap your-{@name}"><input type="text" name="{@name}" class="wpcf7-form-control wpcf7-text wpcf7-email wpcf7-validates-as-email" size="40"/></span></p>
   </xsl:template>

   <xsl:template match="h:textarea">
      <p><xsl:value-of select="@title"/><br/><span class="wpcf7-form-control-wrap your-{@name}"><textarea name="{@name}" class="wpcf7-form-control  wpcf7-textarea" cols="{@cols}" rows="{@rows}"></textarea></span></p>
   </xsl:template>

   <xsl:template match="h:input[@type = 'submit']">
      <p><input type="submit" value="{@value}" class="wpcf7-form-control  wpcf7-submit"/></p>
   </xsl:template>

</xsl:stylesheet>