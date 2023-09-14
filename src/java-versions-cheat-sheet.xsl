<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:jvcs="https://github.com/andbin/java-versions-cheat-sheet"
		exclude-result-prefixes="fn xs jvcs">

	<xsl:output method="html" version="5" encoding="UTF-8"/>

	<xsl:variable name="pageTitle">Java Versions Cheat Sheet</xsl:variable>
	<xsl:variable name="pageDescription">A friendly open-source cheat sheet showing all the Java versions with many valuable information and links</xsl:variable>
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

	<xsl:variable name="epochDateTime" select="xs:dateTime('1970-01-01T00:00:00')"/>
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
		<xsl:variable name="infoUpdatedAtMillis" select="($infoUpdatedAt - fn:timezone-from-dateTime($infoUpdatedAt) - $epochDateTime) div xs:dayTimeDuration('PT0.001S')"/>
		<xsl:variable name="infoUpdatedAtFmt" select="fn:format-dateTime($infoUpdatedAt, '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01] [z]')"/>

		<html lang="en">
			<head>
				<title><xsl:value-of select="$pageTitle"/></title>
				<meta http-equiv="last-modified" content="{$lastModifiedStr}"/>
				<meta name="author" content="Andrea Binello"/>
				<meta name="description" content="{$pageDescription}"/>
				<meta name="generator" content="{$processorInfo}"/>
				<meta name="language" content="English"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<meta property="og:locale" content="en_US"/>
				<meta property="og:type" content="website"/>
				<meta property="og:title" content="{$pageTitle}"/>
				<meta property="og:description" content="{$pageDescription}"/>
				<meta property="og:url" content="{$pageUrl}"/>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css" integrity="sha512-SbiR/eusphKoMVVXysTKG/7VseWii+Y3FdHrt0EpKgpToZeemhqHeZeLWLhJutz/2ut2Vw1uQEj2MbRF+TVBUA==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<link rel="stylesheet" href="fonts/roboto-flex.css{$cacheBusting}"/>
				<link rel="stylesheet" href="styles.css{$cacheBusting}"/>
				<link rel="stylesheet" href="scrolltop.css{$cacheBusting}"/>
			</head>
			<body>
				<div class="container">
					<h1 class="fs-2 pb-1 border-bottom border-2 border-dark mt-3 mb-3">
						<xsl:value-of select="$pageTitle"/>
					</h1>

					<div class="table-responsive mb-3">
						<table class="table table-hover border-secondary text-nowrap mb-1">
							<thead>
								<tr>
									<th scope="col"><span title="Java version">Java version</span></th>
									<th scope="col"><span title="Java Specification Request">JSR</span></th>
									<th scope="col" class="text-end"><span title="First release date">Release date</span></th>
									<th scope="col"><span title="Latest JDK build">Latest build</span></th>
									<th scope="col" class="text-center"><span title="Class file version (major.minor)">Cl. Ver.</span></th>
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
							<span class="fa-li"><i class="fa-solid fa-circle-minus jv-status-old" title="{$oldVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$oldVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle-check jv-status-maintained" title="{$maintainedVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$maintainedVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle-check jv-status-current" title="{$currentVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$currentVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle-question jv-status-future" title="{$futureVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$futureVersion"/>
						</li>
					</ul>

					<div class="mb-5">
						<xsl:apply-templates select="java" mode="card"/>
					</div>

					<footer>
						<div class="pt-3 mb-3 border-top border-2 border-secondary-subtle">
							<ul class="fa-ul mb-0">
								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-calendar-day"></i></span>
									<xsl:text>Java information updated at </xsl:text>
									<span class="jv-updated-at"><xsl:value-of select="$infoUpdatedAtFmt"/></span>
									<script>
										<xsl:text>var daysAgo = Math.floor((Date.now() - new Date(</xsl:text>
										<xsl:value-of select="$infoUpdatedAtMillis"/>
										<xsl:text>)) / 86400000); </xsl:text>
										<xsl:text>document.write(" (" + daysAgo + " " + (daysAgo == 1 ? "day" : "days") + " ago)");</xsl:text>
									</script>
								</li>

								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-circle-user"></i></span>
									<xsl:text>Developed with </xsl:text>
									<i class="fa-solid fa-heart"></i>
									<xsl:text> for Java by Andrea Binello (“andbin”) &#x2013; </xsl:text>
									<a href="https://andbin.dev">andbin.dev</a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-server"></i></span>
									<xsl:text>Hosted on GitHub at </xsl:text>
									<a href="{$projectUrl}"><xsl:value-of select="$projectName"/></a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-code"></i></span>
									<xsl:text>Coded with </xsl:text>
									<a href="https://en.wikipedia.org/wiki/XML" title="eXtensible Markup Language">XML</a>
									<xsl:text>, </xsl:text>
									<a href="https://en.wikipedia.org/wiki/XSL" title="eXtensible Stylesheet Language">XSL</a>
									<xsl:text>, </xsl:text>
									<a href="https://getbootstrap.com">Bootstrap</a>
									<xsl:text>, and </xsl:text>
									<a href="https://fontawesome.com">Font Awesome</a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-gear"></i></span>
									<xsl:text>Generated with </xsl:text>
									<xsl:value-of select="$processorName"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="$processorVersion"/>
									<xsl:text> by </xsl:text>
									<a href="{$processorVendorUrl}"><xsl:value-of select="$processorVendor"/></a>
								</li>

								<li class="mb-1">
									<span class="fa-li"><i class="fa-solid fa-scale-balanced"></i></span>
									<xsl:text>Licensed under a </xsl:text>
									<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>
								</li>

								<li class="mb-0">
									<span class="fa-li"><i class="fa-solid fa-shield-halved"></i></span>
									<xsl:text>Read </xsl:text>
									<a href="https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement">GitHub Privacy Statement</a>
									<xsl:text> (for this page) and </xsl:text>
									<a href="https://www.cloudflare.com/privacypolicy">Cloudflare Privacy Policy</a>
									<xsl:text> (for Bootstrap/Font Awesome usage)</xsl:text>
								</li>
							</ul>
						</div>

						<div class="pt-3 mb-3 border-top border-2 border-secondary-subtle text-center">
							<a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/"><img decoding="async" loading="lazy" src="images/cc-by-sa.svg" class="jv-cc-badge" alt="Creative Commons Attribution-ShareAlike License"/></a>
						</div>
					</footer>
				</div>

				<button type="button" id="scrolltop" data-bs-placement="left" title="Scroll to top"><i class="fa-solid fa-turn-up"></i></button>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.bundle.min.js" integrity="sha512-i9cEfJwUwViEPFKdC1enz4ZRGBj8YQo6QByFTF92YXHi7waCqyexvRD75S5NVTsSiTv7rKWqG9Y5eFxmRsOn0A==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<script src="scrolltop.js{$cacheBusting}"/>
				<script src="script.js{$cacheBusting}"/>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="java" mode="table">
		<tr>
			<th scope="row">
				<xsl:call-template name="status-circle"/>
				<a href="#{jvcs:stringToId(@lang-name)}">
					<xsl:value-of select="@lang-name"/>
				</a>

				<xsl:if test="@lts = 'yes'">
					<xsl:text> </xsl:text>
					<span class="badge rounded-pill text-bg-primary jv-lts-badge" title="Long-Term Support">LTS</span>
				</xsl:if>
			</th>

			<td>
				<xsl:choose>
					<xsl:when test="@jsr-linked">
						<a href="https://jcp.org/en/jsr/summary?id={@jsr-linked}" title="{@edition-name} Java Specification Request"><xsl:value-of select="@jsr-linked"/></a>
					</xsl:when>
					<xsl:when test="@jsr">
						<span title="{@edition-name} Java Specification Request (link not yet available)"><xsl:value-of select="@jsr"/></span>
					</xsl:when>
				</xsl:choose>
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
				<span title="{@lang-name} class file version">
					<xsl:value-of select="@class-major"/>
					<xsl:choose>
						<xsl:when test="@class-minor">.<xsl:value-of select="@class-minor"/></xsl:when>
						<xsl:otherwise>.<em>x</em></xsl:otherwise>
					</xsl:choose>
				</span>
			</td>

			<td>
				<xsl:if test="jdk-docs[1]">
					<a href="{jdk-docs[1]/@url}" title="{jdk-docs[1]/@title}">
						<xsl:text>Doc</xsl:text>
						<xsl:if test="jdk-docs[1]/@type = 'download-page'">
							<i class="fa-solid fa-file-arrow-down jv-ico-right"></i>
						</xsl:if>
					</a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="api-docs[1]">
					<a href="{api-docs[1]/@url}" title="{api-docs[1]/@title}">API</a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="api-diff[1]">
					<a href="{api-diff[1]/@url}" title="{api-diff[1]/@title}">API Diff</a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jls[1]/@web-url">
					<a href="{jls[1]/@web-url}" title="The Java Language Specification, {jls[1]/@edition}">JLS</a>
				</xsl:if>
				<xsl:if test="jls[1]/@web-url and jls[1]/@pdf-url">
					<xsl:text> &#x2022; </xsl:text>
				</xsl:if>
				<xsl:if test="jls[1]/@pdf-url">
					<a href="{jls[1]/@pdf-url}" title="The Java Language Specification, {jls[1]/@edition} (PDF)">JLS<i class="fa-solid fa-file-pdf jv-ico-right"></i></a>
				</xsl:if>
			</td>

			<td>
				<xsl:if test="jvms[1]/@web-url">
					<a href="{jvms[1]/@web-url}" title="The Java Virtual Machine Specification, {jvms[1]/@edition}">JVMS</a>
				</xsl:if>
				<xsl:if test="jvms[1]/@web-url and jvms[1]/@pdf-url">
					<xsl:text> &#x2022; </xsl:text>
				</xsl:if>
				<xsl:if test="jvms[1]/@pdf-url">
					<a href="{jvms[1]/@pdf-url}" title="The Java Virtual Machine Specification, {jvms[1]/@edition} (PDF)">JVMS<i class="fa-solid fa-file-pdf jv-ico-right"></i></a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>


	<xsl:template match="java" mode="card">
		<div id="{jvcs:stringToId(@lang-name)}" class="jv-card-box pt-3">
			<div class="card mb-2 border-secondary">
				<div class="card-body">
					<h5 class="card-title">
						<xsl:value-of select="@lang-name"/>

						<xsl:if test="@edition-name">
							<xsl:text> / </xsl:text>
							<xsl:value-of select="@edition-name"/>
						</xsl:if>

						<xsl:if test="@lts = 'yes'">
							<xsl:text> </xsl:text>
							<span class="badge rounded-pill text-bg-primary jv-lts-badge" title="Long-Term Support">LTS</span>
						</xsl:if>
					</h5>

					<ul class="card-list">
						<li>
							<xsl:text>Status: </xsl:text>
							<xsl:call-template name="status-circle"/>
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

						<xsl:if test="@jsr-linked or @jsr">
							<li>
								<xsl:text>Java Specification Request: </xsl:text>
								<xsl:choose>
									<xsl:when test="@jsr-linked">
										<a href="https://jcp.org/en/jsr/summary?id={@jsr-linked}" class="jv-val">JSR-<xsl:value-of select="@jsr-linked"/></a>
									</xsl:when>
									<xsl:when test="@jsr">
										<span class="jv-val">JSR-<xsl:value-of select="@jsr"/></span>
									</xsl:when>
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
									<xsl:otherwise>.<em>x</em></xsl:otherwise>
								</xsl:choose>
							</span>
						</li>

						<xsl:if test="jdk-docs[1]">
							<li>
								<xsl:text>JDK Documentation: </xsl:text>
								<a href="{jdk-docs[1]/@url}" class="jv-val">
									<xsl:value-of select="jdk-docs[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="api-docs[1]">
							<li>
								<xsl:text>API Specification: </xsl:text>
								<a href="{api-docs[1]/@url}" class="jv-val">
									<xsl:value-of select="api-docs[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="api-diff[1]">
							<li>
								<xsl:text>API Differences: </xsl:text>
								<a href="{api-diff[1]/@url}" class="jv-val">
									<xsl:value-of select="api-diff[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="jls[1]">
							<li>
								<xsl:text>Java Language Specification: </xsl:text>
								<ul>
									<xsl:if test="jls[1]/@web-url">
										<li>
											<a href="{jls[1]/@web-url}" class="jv-val">
												<xsl:text>The Java Language Specification, </xsl:text>
												<xsl:value-of select="jls[1]/@edition"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jls[1]/@pdf-url">
										<li>
											<a href="{jls[1]/@pdf-url}" class="jv-val">
												<xsl:text>The Java Language Specification, </xsl:text>
												<xsl:value-of select="jls[1]/@edition"/>
												<xsl:text> (PDF)</xsl:text>
											</a>
										</li>
									</xsl:if>
								</ul>
							</li>
						</xsl:if>

						<xsl:if test="jvms[1]">
							<li>
								<xsl:text>JVM Specification: </xsl:text>
								<ul>
									<xsl:if test="jvms[1]/@web-url">
										<li>
											<a href="{jvms[1]/@web-url}" class="jv-val">
												<xsl:text>The Java Virtual Machine Specification, </xsl:text>
												<xsl:value-of select="jvms[1]/@edition"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jvms[1]/@pdf-url">
										<li>
											<a href="{jvms[1]/@pdf-url}" class="jv-val">
												<xsl:text>The Java Virtual Machine Specification, </xsl:text>
												<xsl:value-of select="jvms[1]/@edition"/>
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
						<ul class="card-list">
							<xsl:if test="announcement[1]">
								<li>
									<xsl:text>Announcement: </xsl:text>
									<a href="{announcement[1]/@url}" class="jv-val"><xsl:value-of select="announcement[1]/@title"/></a>
								</li>
							</xsl:if>

							<xsl:if test="rel-notes[1]">
								<li>
									<xsl:text>Release notes: </xsl:text>
									<a href="{rel-notes[1]/@url}" class="jv-val"><xsl:value-of select="rel-notes[1]/@title"/></a>
								</li>
							</xsl:if>

							<xsl:if test="sys-confs[1]">
								<li>
									<xsl:text>System configurations: </xsl:text>
									<a href="{sys-confs[1]/@url}" class="jv-val"><xsl:value-of select="sys-confs[1]/@title"/></a>
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
		<span>
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


	<xsl:template name="status-circle">
		<xsl:choose>
			<xsl:when test="@status = 'old'">
				<i class="fa-solid fa-circle-minus jv-status jv-status-old" title="{$oldVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'maintained'">
				<i class="fa-solid fa-circle-check jv-status jv-status-maintained" title="{$maintainedVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'current'">
				<i class="fa-solid fa-circle-check jv-status jv-status-current" title="{$currentVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'future'">
				<i class="fa-solid fa-circle-question jv-status jv-status-future" title="{$futureVersion}"></i>
			</xsl:when>
		</xsl:choose>
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


	<xsl:function name="jvcs:stringToId" as="xs:string">
		<xsl:param name="str" as="xs:string"/>
		<xsl:sequence select="fn:replace(fn:lower-case($str), '\s+', '-')"/>
	</xsl:function>


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

</xsl:stylesheet>
