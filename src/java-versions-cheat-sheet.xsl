<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:jvcs="https://github.com/andbin/java-versions-cheat-sheet"
		exclude-result-prefixes="fn xs jvcs">

	<xsl:output method="html" version="5" encoding="UTF-8"/>

	<xsl:variable name="pageTitle">Java Versions Cheat Sheet</xsl:variable>
	<xsl:variable name="siteName">andbin.github.io/java-versions-cheat-sheet</xsl:variable>
	<xsl:variable name="pageAuthor">Andrea Binello</xsl:variable>
	<xsl:variable name="pageDescription">A friendly open-source cheat sheet showing the Java version history with valuable information and links.</xsl:variable>
	<xsl:variable name="pageUrl">https://andbin.github.io/java-versions-cheat-sheet/</xsl:variable>
	<xsl:variable name="projectName">java-versions-cheat-sheet</xsl:variable>
	<xsl:variable name="projectUrl">https://github.com/andbin/java-versions-cheat-sheet</xsl:variable>

	<xsl:variable name="processorName" select="fn:system-property('xsl:product-name')"/>
	<xsl:variable name="processorVersion" select="fn:system-property('xsl:product-version')"/>
	<xsl:variable name="processorVendor" select="fn:system-property('xsl:vendor')"/>
	<xsl:variable name="processorVendorUrl" select="fn:system-property('xsl:vendor-url')"/>

	<xsl:variable name="processorInfo">
		<xsl:value-of select="$processorName"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$processorVersion"/>
	</xsl:variable>

	<xsl:variable name="epochDateTime" select="xs:dateTime('1970-01-01T00:00:00Z')"/>
	<xsl:variable name="currDateTime" select="fn:current-dateTime()"/>

	<xsl:variable name="lastModifiedStr" select="fn:format-dateTime($currDateTime, '[FNn,3-3], [D01] [MNn,3-3] [Y0001] [H01]:[m01]:00 [z]', 'en', (), ())"/>
	<xsl:variable name="cacheBusting" select="fn:format-dateTime($currDateTime, '?v=[Y01][M01][D01][H01][m01]', 'en', (), ())"/>

	<xsl:variable name="oldVersion">Old version</xsl:variable>
	<xsl:variable name="maintainedVersion">Old version but still maintained</xsl:variable>
	<xsl:variable name="currentVersion">Current version</xsl:variable>
	<xsl:variable name="futureVersion">Future version</xsl:variable>


	<xsl:template match="/">
		<xsl:apply-templates select="java-versions"/>
	</xsl:template>


	<xsl:template match="java-versions">
		<xsl:variable name="infoUpdatedAt" select="xs:dateTime(fn:concat(@update-date, 'T', @update-time, @update-tz))"/>
		<xsl:variable name="infoUpdatedAtMillis" select="($infoUpdatedAt - $epochDateTime) div xs:dayTimeDuration('PT0.001S')"/>
		<xsl:variable name="infoUpdatedAtFmt" select="fn:format-dateTime($infoUpdatedAt, '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01] [z]')"/>

		<html lang="en-US">
			<head>
				<meta charset="UTF-8"/>
				<meta http-equiv="last-modified" content="{$lastModifiedStr}"/>
				<link rel="preconnect" href="https://cdnjs.cloudflare.com"/>
				<title><xsl:value-of select="$pageTitle"/></title>
				<meta name="author" content="{$pageAuthor}"/>
				<meta name="description" content="{$pageDescription}"/>
				<meta name="generator" content="{$processorInfo}"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<meta property="og:description" content="{$pageDescription}"/>
				<meta property="og:locale" content="en_US"/>
				<meta property="og:site_name" content="{$siteName}"/>
				<meta property="og:title" content="{$pageTitle}"/>
				<meta property="og:type" content="website"/>
				<meta property="og:url" content="{$pageUrl}"/>
				<meta property="twitter:description" content="{$pageDescription}"/>
				<meta property="twitter:title" content="{$pageTitle}"/>
				<link rel="canonical" href="{$pageUrl}"/>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css" integrity="sha512-SbiR/eusphKoMVVXysTKG/7VseWii+Y3FdHrt0EpKgpToZeemhqHeZeLWLhJutz/2ut2Vw1uQEj2MbRF+TVBUA==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<link rel="stylesheet" href="fonts/roboto.css{$cacheBusting}"/>
				<link rel="stylesheet" href="styles.css{$cacheBusting}"/>
			</head>
			<body>
				<div class="container">
					<h1 class="fs-2 pb-1 border-bottom border-2 border-dark mt-3 mb-2">
						<span title="{$pageDescription}"><xsl:value-of select="$pageTitle"/></span>
					</h1>

					<div class="table-responsive mb-3">
						<table id="jvcstable" class="table table-hover border-secondary text-nowrap mb-1">
							<thead>
								<tr>
									<th scope="col" colspan="2"><span title="Java version">Java version</span></th>
									<th scope="col"><span title="Java Specification Request">JSR</span></th>
									<th scope="col" class="text-end"><span title="First release date">Release date</span></th>
									<th scope="col"><span title="Latest JDK build">Latest build</span></th>
									<th scope="col" class="text-center"><span title="Class file version (major.minor)">Class<br/>Ver.</span></th>
									<th scope="col" class="text-center"><span title="Unicode Standard version (as specified by class java.lang.Character)">Unicode<br/>Ver.</span></th>
									<th scope="col"><span title="JDK Documentation">Doc.</span></th>
									<th scope="col"><span title="API Specification">API</span></th>
									<th scope="col"><span title="API Differences">API Diff.</span></th>
									<th scope="col"><span title="Java Language Specification">JLS</span></th>
									<th scope="col"><span title="Java Virtual Machine Specification">JVMS</span></th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="java" mode="table"/>
							</tbody>
						</table>
					</div>

					<ul class="fa-ul mb-5">
						<li class="mb-1">
							<span class="fa-li"><xsl:sequence select="jvcs:icon('old-version-legend')"/></span>
							<xsl:sequence select="jvcs:icon('arrow-right')"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$oldVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><xsl:sequence select="jvcs:icon('maintained-version-legend')"/></span>
							<xsl:sequence select="jvcs:icon('arrow-right')"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$maintainedVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><xsl:sequence select="jvcs:icon('current-version-legend')"/></span>
							<xsl:sequence select="jvcs:icon('arrow-right')"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$currentVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><xsl:sequence select="jvcs:icon('future-version-legend')"/></span>
							<xsl:sequence select="jvcs:icon('arrow-right')"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$futureVersion"/>
						</li>
					</ul>

					<div class="mb-5 card jv-resources">
						<div class="card-body">
							<h5 class="card-title">Oracle Resources</h5>
							<div class="row">
								<span><a href="https://blogs.oracle.com/java/" title="Oracle Blogs | Java Blog">Java Blog</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/javase/codeconventions-contents.html" title="Code Conventions for the Java Programming Language">Java Code Conventions</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/downloads/" title="Java Downloads | Oracle">Java Downloads</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/javase/vmoptions-jsp.html" title="Java HotSpot VM Options">Java HotSpot VM Options</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/javase/seccodeguide.html" title="Secure Coding Guidelines for Java SE">Java SE Secure Coding</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/java-se-support-roadmap.html" title="Oracle Java SE Support Roadmap">Java SE Support Roadmap</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/" title="Oracle Java Technologies | Oracle">Java Technologies</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://docs.oracle.com/javase/tutorial/" title="The Java™ Tutorials">Java Tutorials</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/javase/jdk-relnotes-index.html" title="JDK Release Notes">JDK Release Notes</a></span>
								<xsl:text> </xsl:text>
								<span><a href="https://www.oracle.com/java/technologies/tzdata-versions.html" title="Timezone Data Versions in the JRE Software">JRE Timezone Data Versions</a></span>
							</div>
						</div>
					</div>

					<div class="mb-5">
						<xsl:apply-templates select="java" mode="card"/>
					</div>

					<footer>
						<div class="pt-3 mb-3 border-top border-2 border-secondary-subtle">
							<ul class="fa-ul mb-0">
								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('updated-at')"/></span>
									<xsl:text>Java information updated at </xsl:text>
									<span class="jv-updated-at"><xsl:value-of select="$infoUpdatedAtFmt"/></span>
									<xsl:text> </xsl:text>
									<span id="jvcsdaysago" data-millis="{$infoUpdatedAtMillis}"></span>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('developed-by')"/></span>
									<xsl:text>Developed with love</xsl:text>
									<xsl:sequence select="jvcs:icon('with-love')"/>
									<xsl:text> for Java by Andrea Binello (“andbin”) &#x2013; </xsl:text>
									<a href="https://andbin.dev">andbin.dev</a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('hosted')"/></span>
									<xsl:text>Hosted on </xsl:text>
									<a href="https://github.com">GitHub</a>
									<xsl:text> at </xsl:text>
									<a href="{$projectUrl}"><xsl:value-of select="$projectName"/></a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('coded')"/></span>
									<xsl:text>Coded with </xsl:text>
									<a href="https://en.wikipedia.org/wiki/XML" title="eXtensible Markup Language">XML</a>
									<xsl:text>, </xsl:text>
									<a href="https://en.wikipedia.org/wiki/XSL" title="eXtensible Stylesheet Language">XSL</a>
									<xsl:text>, </xsl:text>
									<a href="https://getbootstrap.com">Bootstrap</a>
									<xsl:text>, </xsl:text>
									<a href="https://jquery.com">jQuery</a>
									<xsl:text>, and </xsl:text>
									<a href="https://fontawesome.com">Font Awesome</a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('generated')"/></span>
									<xsl:text>Generated with </xsl:text>
									<xsl:value-of select="$processorName"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="$processorVersion"/>
									<xsl:text> by </xsl:text>
									<a href="{$processorVendorUrl}"><xsl:value-of select="$processorVendor"/></a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('licensed')"/></span>
									<xsl:text>Licensed under a </xsl:text>
									<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('privacy')"/></span>
									<xsl:text>Read </xsl:text>
									<a href="https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement">GitHub Privacy Statement</a>
									<xsl:text> (for this page) and </xsl:text>
									<a href="https://www.cloudflare.com/privacypolicy">Cloudflare Privacy Policy</a>
									<xsl:text> (for Bootstrap/jQuery/Font Awesome usage)</xsl:text>
								</li>

								<li class="mb-0">
									<span class="fa-li"><xsl:sequence select="jvcs:icon('registered')"/></span>
									<xsl:text>Oracle® and Java are registered trademarks of </xsl:text>
									<a href="https://www.oracle.com">Oracle</a>
								</li>
							</ul>
						</div>

						<div class="pt-3 mb-3 border-top border-2 border-secondary-subtle text-center">
							<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img decoding="async" loading="lazy" src="images/cc-by-sa.svg" class="jv-cc-banner" alt="Creative Commons Attribution-ShareAlike License" title="Creative Commons Attribution-ShareAlike License"/></a>
						</div>
					</footer>
				</div>

				<button type="button" id="scrolltop" data-bs-placement="left" title="Scroll to top">
					<xsl:sequence select="jvcs:icon('scroll-top')"/>
				</button>

				<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.slim.min.js" integrity="sha512-sNylduh9fqpYUK5OYXWcBleGzbZInWj8yCJAU57r1dpSK9tP2ghf/SRYCMj+KsslFkCOt3TvJrX2AV/Gc3wOqA==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.bundle.min.js" integrity="sha512-i9cEfJwUwViEPFKdC1enz4ZRGBj8YQo6QByFTF92YXHi7waCqyexvRD75S5NVTsSiTv7rKWqG9Y5eFxmRsOn0A==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<script src="script.js{$cacheBusting}"/>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="java" mode="table">
		<tr>
			<th scope="row" class="pe-1">
				<xsl:call-template name="status-icon"/>
				<a href="#{@id}">
					<xsl:value-of select="@lang-name"/>
				</a>
			</th>

			<td class="ps-1">
				<xsl:if test="@lts = 'yes'">
					<span class="jv-lts badge rounded-pill" title="Long-Term Support">LTS</span>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jsr[1]">
					<xsl:choose>
						<xsl:when test="jsr[1]/@nolink">
							<span title="{@edition-name} Java Specification Request (link not yet available)"><xsl:value-of select="jsr[1]/@id"/></span>
						</xsl:when>
						<xsl:otherwise>
							<a href="https://jcp.org/en/jsr/summary?id={jsr[1]/@id}" title="{@edition-name} Java Specification Request"><xsl:value-of select="jsr[1]/@id"/></a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>

			<td class="text-end">
				<xsl:if test="@release-date">
					<span title="{@lang-name} release date">
						<xsl:value-of select="jvcs:dateStr(@release-date)"/>
					</span>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="latest-build">
					<xsl:apply-templates select="latest-build" mode="table"/>
				</xsl:if>
			</td>

			<td class="text-center">
				<span title="{@lang-name} class file version (major.minor)">
					<xsl:value-of select="@class-major"/>
					<xsl:choose>
						<xsl:when test="@class-minor">.<xsl:value-of select="@class-minor"/></xsl:when>
						<xsl:otherwise>.x</xsl:otherwise>
					</xsl:choose>
				</span>
			</td>

			<td class="text-center">
				<xsl:if test="unicode[1]">
					<xsl:choose>
						<xsl:when test="unicode[1]/@url">
							<a href="{unicode[1]/@url}" title="{@edition-name} Unicode Standard version"><xsl:value-of select="unicode[1]/@version"/></a>
						</xsl:when>
						<xsl:otherwise>
							<span title="{@edition-name} Unicode Standard version"><xsl:value-of select="unicode[1]/@version"/></span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jdk-docs[1]">
					<a href="{jdk-docs[1]/@url}" title="{jdk-docs[1]/@title}">Doc</a>
					<xsl:if test="jdk-docs[1]/@type = 'download-page'">
						<xsl:sequence select="jvcs:icon('download-page')"/>
					</xsl:if>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="api-docs[1]">
					<a href="{api-docs[1]/@url}">
						<xsl:attribute name="title">
							<xsl:value-of select="api-docs[1]/@title"/>
							<xsl:if test="api-docs[1]/@draft = 'yes'">
								<xsl:text> [DRAFT]</xsl:text>
							</xsl:if>
						</xsl:attribute>
						<xsl:text>API</xsl:text>
					</a>
					<xsl:if test="api-docs[1]/@draft = 'yes'">
						<xsl:sequence select="jvcs:icon('api-draft')"/>
					</xsl:if>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="api-diff[1]">
					<a href="{api-diff[1]/@url}" title="{api-diff[1]/@title}">API Diff</a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jls-docs[1]/@web-url">
					<a href="{jls-docs[1]/@web-url}" title="{jls-docs[1]/@title}">JLS</a>
				</xsl:if>
				<xsl:if test="jls-docs[1]/@web-url and jls-docs[1]/@pdf-url">
					<span class="jv-sep">|</span>
				</xsl:if>
				<xsl:if test="jls-docs[1]/@pdf-url">
					<a href="{jls-docs[1]/@pdf-url}" title="{jls-docs[1]/@title} (PDF)">JLS<xsl:sequence select="jvcs:icon('pdf-file')"/></a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jvms-docs[1]/@web-url">
					<a href="{jvms-docs[1]/@web-url}" title="{jvms-docs[1]/@title}">JVMS</a>
				</xsl:if>
				<xsl:if test="jvms-docs[1]/@web-url and jvms-docs[1]/@pdf-url">
					<span class="jv-sep">|</span>
				</xsl:if>
				<xsl:if test="jvms-docs[1]/@pdf-url">
					<a href="{jvms-docs[1]/@pdf-url}" title="{jvms-docs[1]/@title} (PDF)">JVMS<xsl:sequence select="jvcs:icon('pdf-file')"/></a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>


	<xsl:template match="java" mode="card">
		<div id="{@id}" class="jv-card-box pt-3">
			<div class="card mb-2">
				<h5 class="card-header">
					<xsl:value-of select="@lang-name"/>

					<xsl:if test="@edition-name">
						<xsl:text> / </xsl:text>
						<xsl:value-of select="@edition-name"/>
					</xsl:if>

					<xsl:if test="@lts = 'yes'">
						<xsl:text> </xsl:text>
						<span class="jv-lts badge rounded-pill" title="Long-Term Support">LTS</span>
					</xsl:if>
				</h5>

				<div class="card-body">
					<ul>
						<li>
							<xsl:text>Status: </xsl:text>
							<xsl:call-template name="status-icon"/>
							<span class="jv-val">
								<xsl:call-template name="status-desc"/>
							</span>
						</li>

						<xsl:if test="code-name">
							<li>
								<xsl:choose>
									<xsl:when test="fn:count(code-name) gt 1">
										<xsl:text>Code-names:</xsl:text>
										<ul>
											<xsl:apply-templates select="code-name" mode="card"/>
										</ul>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Code-name: </xsl:text>
										<span class="jv-val">
											<xsl:text>“</xsl:text>
											<xsl:value-of select="code-name[1]/text()"/>
											<xsl:text>”</xsl:text>
										</span>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:if>

						<xsl:if test="jsr[1]">
							<li>
								<xsl:text>Java Specification Request: </xsl:text>
								<xsl:choose>
									<xsl:when test="jsr[1]/@nolink">
										<span class="jv-val">JSR <xsl:value-of select="jsr[1]/@id"/></span>
									</xsl:when>
									<xsl:otherwise>
										<a href="https://jcp.org/en/jsr/summary?id={jsr[1]/@id}">JSR <xsl:value-of select="jsr[1]/@id"/>: <xsl:value-of select="jsr[1]/@title"/></a>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:if>

						<xsl:if test="@release-date">
							<li>
								<xsl:text>Release date: </xsl:text>
								<span class="jv-val">
									<xsl:value-of select="jvcs:dateStr(@release-date)"/>
								</span>
							</li>
						</xsl:if>

						<xsl:if test="latest-build">
							<li>
								<xsl:text>Latest JDK build:</xsl:text>
								<ul>
									<xsl:apply-templates select="latest-build" mode="card"/>
								</ul>
							</li>
						</xsl:if>

						<li>
							<xsl:text>Class file version (major.minor): </xsl:text>
							<span class="jv-val">
								<xsl:value-of select="@class-major"/>
								<xsl:choose>
									<xsl:when test="@class-minor">.<xsl:value-of select="@class-minor"/></xsl:when>
									<xsl:otherwise>.x</xsl:otherwise>
								</xsl:choose>
							</span>
						</li>

						<xsl:if test="unicode[1]">
							<li>
								<xsl:text>Unicode Standard version: </xsl:text>
								<span class="jv-val">
									<xsl:value-of select="unicode[1]/@version"/>
								</span>
								<xsl:if test="unicode[1]/@url">
									<xsl:text> (</xsl:text>
									<a href="{unicode[1]/@url}"><xsl:value-of select="unicode[1]/@name"/></a>
									<xsl:text>)</xsl:text>
								</xsl:if>
							</li>
						</xsl:if>

						<xsl:if test="jdk-docs[1]">
							<li>
								<xsl:text>JDK Documentation: </xsl:text>
								<a href="{jdk-docs[1]/@url}">
									<xsl:value-of select="jdk-docs[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="api-docs[1]">
							<li>
								<xsl:text>API Specification: </xsl:text>
								<a href="{api-docs[1]/@url}">
									<xsl:value-of select="api-docs[1]/@title"/>
								</a>
								<xsl:if test="api-docs[1]/@draft = 'yes'">
									<xsl:text> </xsl:text>
									<span class="badge rounded-pill jv-draft" title="This API Specification is a “DRAFT”">DRAFT</span>
								</xsl:if>
							</li>
						</xsl:if>

						<xsl:if test="api-diff[1]">
							<li>
								<xsl:text>API Differences: </xsl:text>
								<a href="{api-diff[1]/@url}">
									<xsl:value-of select="api-diff[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="jls-docs[1]">
							<li>
								<xsl:text>Java Language Specification: </xsl:text>
								<ul>
									<xsl:if test="jls-docs[1]/@web-url">
										<li>
											<a href="{jls-docs[1]/@web-url}">
												<xsl:value-of select="jls-docs[1]/@title"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jls-docs[1]/@pdf-url">
										<li>
											<a href="{jls-docs[1]/@pdf-url}">
												<xsl:value-of select="jls-docs[1]/@title"/>
												<xsl:text> (PDF)</xsl:text>
											</a>
										</li>
									</xsl:if>
								</ul>
							</li>
						</xsl:if>

						<xsl:if test="jvms-docs[1]">
							<li>
								<xsl:text>JVM Specification: </xsl:text>
								<ul>
									<xsl:if test="jvms-docs[1]/@web-url">
										<li>
											<a href="{jvms-docs[1]/@web-url}">
												<xsl:value-of select="jvms-docs[1]/@title"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jvms-docs[1]/@pdf-url">
										<li>
											<a href="{jvms-docs[1]/@pdf-url}">
												<xsl:value-of select="jvms-docs[1]/@title"/>
												<xsl:text> (PDF)</xsl:text>
											</a>
										</li>
									</xsl:if>
								</ul>
							</li>
						</xsl:if>
					</ul>

					<xsl:if test="announcement[1] or rel-notes[1] or sys-confs[1]">
						<h6 class="jv-extra-info">EXTRA INFO:</h6>
						<ul>
							<xsl:if test="announcement[1]">
								<li>
									<xsl:text>Announcement: </xsl:text>
									<a href="{announcement[1]/@url}"><xsl:value-of select="announcement[1]/@title"/></a>
								</li>
							</xsl:if>

							<xsl:if test="rel-notes[1]">
								<li>
									<xsl:text>Release notes: </xsl:text>
									<a href="{rel-notes[1]/@url}"><xsl:value-of select="rel-notes[1]/@title"/></a>
								</li>
							</xsl:if>

							<xsl:if test="sys-confs[1]">
								<li>
									<xsl:text>System configurations: </xsl:text>
									<a href="{sys-confs[1]/@url}"><xsl:value-of select="sys-confs[1]/@title"/></a>
								</li>
							</xsl:if>
						</ul>
					</xsl:if>
				</div>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="latest-build" mode="table">
		<xsl:if test="position() gt 1">
			<xsl:text> / </xsl:text>
		</xsl:if>
		<span class="latest-build">
			<xsl:if test="@release-date">
				<xsl:attribute name="data-release-date"><xsl:value-of select="@release-date"/></xsl:attribute>
			</xsl:if>

			<xsl:attribute name="title">
				<xsl:text>Latest </xsl:text>
				<xsl:value-of select="../@jdk-name"/>
				<xsl:text> build</xsl:text>
				<xsl:choose>
					<xsl:when test="@channel">
						<xsl:text> &#x2013; </xsl:text>
						<xsl:value-of select="@channel"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> &#x2013; Public</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="@release-date">
					<xsl:text>&lt;br&gt;Released on &lt;strong&gt;</xsl:text>
					<xsl:value-of select="jvcs:dateStr(@release-date)"/>
					<xsl:text>&lt;/strong&gt;</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<xsl:value-of select="@version"/>
		</span>
	</xsl:template>


	<xsl:template match="latest-build" mode="card">
		<li>
			<span class="jv-val">
				<xsl:value-of select="@version"/>
			</span>
			<xsl:if test="@full-version">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@full-version"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
			<xsl:if test="@release-date">
				<xsl:text> released on </xsl:text>
				<span class="jv-val">
					<xsl:value-of select="jvcs:dateStr(@release-date)"/>
				</span>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@channel">
					<xsl:text> &#x2013; </xsl:text>
					<span class="jv-val">
						<xsl:value-of select="@channel"/>
					</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> &#x2013; </xsl:text>
					<span class="jv-val">Public</span>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>


	<xsl:template match="code-name" mode="card">
		<li>
			<span class="jv-val">
				<xsl:text>“</xsl:text>
				<xsl:value-of select="text()"/>
				<xsl:text>”</xsl:text>
			</span>

			<xsl:if test="@version">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="@version"/>
				<xsl:text>)</xsl:text>
			</xsl:if>
		</li>
	</xsl:template>


	<xsl:template name="status-icon">
		<xsl:sequence select="jvcs:icon(fn:concat(@status, '-version'))"/>
	</xsl:template>


	<xsl:template name="status-desc">
		<xsl:choose>
			<xsl:when test="@status = 'old'">
				<xsl:value-of select="$oldVersion"/>
			</xsl:when>
			<xsl:when test="@status = 'maintained'">
				<xsl:value-of select="$maintainedVersion"/>
			</xsl:when>
			<xsl:when test="@status = 'current'">
				<xsl:value-of select="$currentVersion"/>
			</xsl:when>
			<xsl:when test="@status = 'future'">
				<xsl:value-of select="$futureVersion"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xsl:function name="jvcs:dateStr" as="xs:string">
		<xsl:param name="dt" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="fn:matches($dt, '^\d{4}-\d{2}$')">
				<xsl:sequence select="fn:format-date(xs:date(concat($dt, '-01')), '[MNn] [Y]', 'en', (), ())"/>
			</xsl:when>
			<xsl:when test="fn:matches($dt, '^\d{4}-\d{2}-\d{2}$')">
				<xsl:sequence select="fn:format-date(xs:date($dt), '[MNn] [D], [Y]', 'en', (), ())"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">Invalid date argument: <xsl:value-of select="$dt"/></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>


	<xsl:function name="jvcs:icon">
		<xsl:param name="key" as="xs:string"/>
		<xsl:choose>
			<xsl:when test="$key = 'old-version'">
				<i class="fa-solid fa-circle-minus jv-status jv-old" title="{$oldVersion}"></i>
			</xsl:when>
			<xsl:when test="$key = 'old-version-legend'">
				<i class="fa-solid fa-circle-minus jv-status jv-old" aria-hidden="true"></i>
			</xsl:when>

			<xsl:when test="$key = 'maintained-version'">
				<i class="fa-solid fa-circle-check jv-status jv-maintained" title="{$maintainedVersion}"></i>
			</xsl:when>
			<xsl:when test="$key = 'maintained-version-legend'">
				<i class="fa-solid fa-circle-check jv-status jv-maintained" aria-hidden="true"></i>
			</xsl:when>

			<xsl:when test="$key = 'current-version'">
				<i class="fa-solid fa-circle-check jv-status jv-current" title="{$currentVersion}"></i>
			</xsl:when>
			<xsl:when test="$key = 'current-version-legend'">
				<i class="fa-solid fa-circle-check jv-status jv-current" aria-hidden="true"></i>
			</xsl:when>

			<xsl:when test="$key = 'future-version'">
				<i class="fa-solid fa-circle-question jv-status jv-future" title="{$futureVersion}"></i>
			</xsl:when>
			<xsl:when test="$key = 'future-version-legend'">
				<i class="fa-solid fa-circle-question jv-status jv-future" aria-hidden="true"></i>
			</xsl:when>

			<xsl:when test="$key = 'arrow-right'">
				<i class="fa-solid fa-arrow-right-long" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'updated-at'">
				<i class="fa-solid fa-calendar-day" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'developed-by'">
				<i class="fa-solid fa-circle-user" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'with-love'">
				<i class="fa-solid fa-heart" aria-hidden="true" style="padding-left:0.25em"></i>
			</xsl:when>
			<xsl:when test="$key = 'hosted'">
				<i class="fa-solid fa-server" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'coded'">
				<i class="fa-solid fa-code" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'generated'">
				<i class="fa-solid fa-gear" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'licensed'">
				<i class="fa-solid fa-scale-balanced" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'privacy'">
				<i class="fa-solid fa-shield-halved" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'registered'">
				<i class="fa-solid fa-registered" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'scroll-top'">
				<i class="fa-solid fa-turn-up" aria-hidden="true"></i>
			</xsl:when>
			<xsl:when test="$key = 'download-page'">
				<i class="fa-solid fa-file-arrow-down jv-ico-right" title="Download page"></i>
			</xsl:when>
			<xsl:when test="$key = 'api-draft'">
				<i class="fa-solid fa-pencil jv-draft" title="This API Specification is a “DRAFT”"></i>
			</xsl:when>
			<xsl:when test="$key = 'pdf-file'">
				<i class="fa-solid fa-file-pdf jv-ico-right" aria-hidden="true"></i>
			</xsl:when>

			<xsl:otherwise>
				<xsl:message terminate="yes">Invalid icon key: <xsl:value-of select="$key"/></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>
