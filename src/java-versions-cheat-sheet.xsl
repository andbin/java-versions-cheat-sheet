<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="fn xs">

	<xsl:output method="html" version="5" encoding="UTF-8"/>

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

	<xsl:variable name="oldVersion">Old version</xsl:variable>
	<xsl:variable name="maintainedVersion">Old version but still maintained</xsl:variable>
	<xsl:variable name="currentVersion">Current version</xsl:variable>
	<xsl:variable name="futureVersion">Future version</xsl:variable>


	<xsl:template match="/">
		<xsl:apply-templates select="java-versions"/>
	</xsl:template>


	<xsl:template match="java-versions">
		<xsl:variable name="updatedAt" select="xs:dateTime(fn:concat(@update-date, 'T', @update-time, @update-tz))"/>
		<xsl:variable name="updatedAtMillis" select="($updatedAt - fn:timezone-from-dateTime($updatedAt) - $epochDateTime) div xs:dayTimeDuration('PT0.001S')"/>
		<xsl:variable name="updatedAtFmt" select="fn:format-dateTime($updatedAt, '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01] [z]')"/>

		<html lang="en">
			<head>
				<title>Java Versions Cheat Sheet</title>
				<meta name="author" content="Andrea Binello"/>
				<meta name="description" content="An open-source cheat sheet showing all the Java versions with valuable information and links"/>
				<meta name="generator" content="{$processorInfo}"/>
				<meta name="language" content="English"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
				<link rel="stylesheet" href="styles.css"/>
			</head>
			<body>
				<div class="container">
					<div class="jumbotron border-bottom border-2 border-dark mt-2 mb-2">
						<h1 class="fs-2 fw-semibold">Java Versions Cheat Sheet</h1>
					</div>

					<div class="table-responsive mb-3">
						<table class="java-versions table table-hover border-secondary text-nowrap mb-1">
							<thead>
								<tr>
									<th scope="col" title="Java version">Java version</th>
									<th scope="col" title="Java Specification Request">JSR</th>
									<th scope="col" title="Release date" class="text-end">Release date</th>
									<th scope="col" title="Latest JDK build">Latest<br/>build</th>
									<th scope="col" title="Class file version (major.minor)">Class<br/>vers.</th>
									<th scope="col" title="JDK Documentation">JDK<br/>Doc.</th>
									<th scope="col" title="API Specification">API<br/>Spec.</th>
									<th scope="col" title="API Differences">API Diff.</th>
									<th scope="col" title="Java Language Specification">JLS</th>
									<th scope="col" title="Java Virtual Machine Specification">JVMS</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="java" mode="table"/>
							</tbody>
						</table>
					</div>

					<ul class="fa-ul mb-5">
						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle old-version" title="{$oldVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$oldVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle maintained-version" title="{$maintainedVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$maintainedVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle-check current-version" title="{$currentVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$currentVersion"/>
						</li>

						<li class="mb-1">
							<span class="fa-li"><i class="fa-solid fa-circle future-version" title="{$futureVersion}"></i></span>
							<i class="fa-solid fa-arrow-right-long"></i>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$futureVersion"/>
						</li>
					</ul>

					<div class="mb-5">
						<xsl:apply-templates select="java" mode="card"/>
					</div>

					<footer class="pt-3 pb-3 mb-3 border-top border-bottom border-2 border-secondary-subtle">
						<ul class="fa-ul mb-0">
							<li class="mb-1">
								<span class="fa-li"><i class="fa-solid fa-calendar-day"></i></span>
								<xsl:text>Java information updated at </xsl:text>
								<span class="updated-at"><xsl:value-of select="$updatedAtFmt"/></span>
								<script>
									<xsl:text>var daysAgo = Math.floor((Date.now() - new Date(</xsl:text>
									<xsl:value-of select="$updatedAtMillis"/>
									<xsl:text>)) / 86400000); </xsl:text>
									<xsl:text>document.write(" (" + daysAgo + " " + (daysAgo == 1 ? "day" : "days") + " ago)");</xsl:text>
								</script>
							</li>

							<li class="mb-1">
								<span class="fa-li"><i class="fa-solid fa-circle-user"></i></span>
								<xsl:text>Developed by Andrea Binello (“andbin”) &#x2013; </xsl:text>
								<a href="https://andbin.dev">andbin.dev</a>
							</li>

							<li class="mb-1">
								<span class="fa-li"><i class="fa-brands fa-github"></i></span>
								<xsl:text>Hosted on GitHub at </xsl:text>
								<a href="https://github.com/andbin/java-versions-cheat-sheet">java-versions-cheat-sheet</a>
							</li>

							<li class="mb-1">
								<span class="fa-li"><i class="fa-solid fa-code"></i></span>
								<xsl:text>Coded with XML/XSL, </xsl:text>
								<a href="https://getbootstrap.com"><i class="fa-brands fa-bootstrap ico-left"></i>Bootstrap</a>
								<xsl:text>, and </xsl:text>
								<a href="https://fontawesome.com/"><i class="fa-solid fa-font-awesome ico-left"></i>Font Awesome</a>
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

							<li>
								<span class="fa-li"><i class="fa-solid fa-scale-balanced"></i></span>
								<xsl:text>Licensed under a </xsl:text>
								<a href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>
								<xsl:text> </xsl:text>
								<i class="fa-brands fa-creative-commons fa-xl"></i>
								<xsl:text> </xsl:text>
								<i class="fa-brands fa-creative-commons-by fa-xl"></i>
								<xsl:text> </xsl:text>
								<i class="fa-brands fa-creative-commons-sa fa-xl"></i>
							</li>
						</ul>
					</footer>
				</div>

				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"/>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="java" mode="table">
		<tr>
			<th class="version" scope="row">
				<xsl:call-template name="status-circle"/>
				<xsl:text> </xsl:text>
				<a href="#java-{@version}">
					<xsl:text>Java </xsl:text>
					<xsl:value-of select="@version"/>
				</a>

				<xsl:if test="@lts = 'yes'">
					<xsl:text> </xsl:text>
					<span class="badge rounded-pill text-bg-primary lts-badge" title="Long-Term Support">LTS</span>
				</xsl:if>
			</th>

			<td class="jsr">
				<xsl:choose>
					<xsl:when test="@jsr-linked">
						<a href="https://jcp.org/en/jsr/summary?id={@jsr-linked}" title="Java SE {@version} Java Specification Request"><xsl:value-of select="@jsr-linked"/></a>
					</xsl:when>
					<xsl:when test="@jsr">
						<span title="Java SE {@version} Java Specification Request (link not yet available)"><xsl:value-of select="@jsr"/></span>
					</xsl:when>
				</xsl:choose>
			</td>

			<td class="rel-date text-end">
				<span title="Java {@version} release date">
					<xsl:value-of select="@release-date"/>
				</span>
			</td>

			<td class="latest-build">
				<span title="Latest JDK {@version} build">
					<xsl:value-of select="@latest-build"/>
				</span>
			</td>

			<td class="class-ver">
				<span title="Java {@version} class file version">
					<xsl:value-of select="@class-major"/>
					<xsl:choose>
						<xsl:when test="@class-minor">.<xsl:value-of select="@class-minor"/></xsl:when>
						<xsl:otherwise>.<em>x</em></xsl:otherwise>
					</xsl:choose>
				</span>
			</td>

			<td class="jdk-docs">
				<xsl:if test="jdk-docs[1]">
					<a href="{jdk-docs[1]/@url}" title="{jdk-docs[1]/@title}">
						<xsl:text>Doc</xsl:text>
						<xsl:if test="jdk-docs[1]/@type = 'download-page'">
							<i class="fa-solid fa-file-arrow-down ico-right"></i>
						</xsl:if>
					</a>
				</xsl:if>
			</td>

			<td class="api-docs">
				<xsl:if test="api-docs[1]">
					<a href="{api-docs[1]/@url}" title="{api-docs[1]/@title}">API</a>
				</xsl:if>
			</td>

			<td class="api-diff">
				<xsl:if test="api-diff[1]">
					<a href="{api-diff[1]/@url}" title="{api-diff[1]/@title}">API Diff</a>
				</xsl:if>
			</td>

			<td class="jls">
				<xsl:if test="jls[1]/@web-url">
					<a href="{jls[1]/@web-url}" title="The Java Language Specification, {jls[1]/@edition}">JLS</a>
				</xsl:if>
				<xsl:if test="jls[1]/@web-url and jls[1]/@pdf-url">
					<xsl:text> &#x2022; </xsl:text>
				</xsl:if>
				<xsl:if test="jls[1]/@pdf-url">
					<a href="{jls[1]/@pdf-url}" title="The Java Language Specification, {jls[1]/@edition} (PDF)">JLS<i class="fa-solid fa-file-pdf ico-right"></i></a>
				</xsl:if>
			</td>

			<td class="jvms">
				<xsl:if test="jvms[1]/@web-url">
					<a href="{jvms[1]/@web-url}" title="The Java Virtual Machine Specification, {jvms[1]/@edition}">JVMS</a>
				</xsl:if>
				<xsl:if test="jvms[1]/@web-url and jvms[1]/@pdf-url">
					<xsl:text> &#x2022; </xsl:text>
				</xsl:if>
				<xsl:if test="jvms[1]/@pdf-url">
					<a href="{jvms[1]/@pdf-url}" title="The Java Virtual Machine Specification, {jvms[1]/@edition} (PDF)">JVMS<i class="fa-solid fa-file-pdf ico-right"></i></a>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>


	<xsl:template match="java" mode="card">
		<div id="java-{@version}" class="card-box pt-3">
			<div class="card mb-2 border-secondary">
				<div class="card-body">
					<h5 class="card-title">
						<span class="value">
							<xsl:text>Java </xsl:text>
							<xsl:value-of select="@version"/>
						</span>

						<xsl:if test="@lts = 'yes'">
							<xsl:text> </xsl:text>
							<span class="badge rounded-pill text-bg-primary lts-badge" title="Long-Term Support">LTS</span>
						</xsl:if>
					</h5>

					<ul class="card-list">
						<li>
							<xsl:text>Status: </xsl:text>
							<xsl:call-template name="status-circle"/>
							<xsl:text> </xsl:text>
							<span class="value">
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
										<span class="value">
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
										<a href="https://jcp.org/en/jsr/summary?id={@jsr-linked}" class="value" title="Java SE {@version} Java Specification Request">JSR-<xsl:value-of select="@jsr-linked"/></a>
									</xsl:when>
									<xsl:when test="@jsr">
										<span class="value" title="Java SE {@version} Java Specification Request (link not yet available)">JSR-<xsl:value-of select="@jsr"/></span>
									</xsl:when>
								</xsl:choose>
							</li>
						</xsl:if>

						<xsl:if test="@release-date">
							<li>
								<xsl:text>Release date: </xsl:text>
								<span class="value">
									<xsl:value-of select="@release-date"/>
								</span>
							</li>
						</xsl:if>

						<xsl:if test="@latest-build">
							<li>
								<xsl:text>Latest JDK build: </xsl:text>
								<span class="value">
									<xsl:value-of select="@latest-build"/>
								</span>
							</li>
						</xsl:if>

						<li>
							<xsl:text>Class file version (major.minor): </xsl:text>
							<span class="value">
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
								<a href="{jdk-docs[1]/@url}" class="value">
									<xsl:value-of select="jdk-docs[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="api-docs[1]">
							<li>
								<xsl:text>API Specification: </xsl:text>
								<a href="{api-docs[1]/@url}" class="value">
									<xsl:value-of select="api-docs[1]/@title"/>
								</a>
							</li>
						</xsl:if>

						<xsl:if test="api-diff[1]">
							<li>
								<xsl:text>API Differences: </xsl:text>
								<a href="{api-diff[1]/@url}" class="value">
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
											<a href="{jls[1]/@web-url}" class="value">
												<xsl:text>The Java Language Specification, </xsl:text>
												<xsl:value-of select="jls[1]/@edition"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jls[1]/@pdf-url">
										<li>
											<a href="{jls[1]/@pdf-url}" class="value">
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
											<a href="{jvms[1]/@web-url}" class="value">
												<xsl:text>The Java Virtual Machine Specification, </xsl:text>
												<xsl:value-of select="jvms[1]/@edition"/>
											</a>
										</li>
									</xsl:if>
									<xsl:if test="jvms[1]/@pdf-url">
										<li>
											<a href="{jvms[1]/@pdf-url}" class="value">
												<xsl:text>The Java Virtual Machine Specification, </xsl:text>
												<xsl:value-of select="jvms[1]/@edition"/>
												<xsl:text> (PDF)</xsl:text>
											</a>
										</li>
									</xsl:if>
								</ul>
							</li>
						</xsl:if>

						<xsl:if test="rel-notes[1]">
							<li>
								<xsl:text>Release notes: </xsl:text>
								<a href="{rel-notes[1]/@url}" class="value"><xsl:value-of select="rel-notes[1]/@title"/></a>
							</li>
						</xsl:if>

						<xsl:if test="sys-confs[1]">
							<li>
								<xsl:text>System configurations: </xsl:text>
								<a href="{sys-confs[1]/@url}" class="value"><xsl:value-of select="sys-confs[1]/@title"/></a>
							</li>
						</xsl:if>
					</ul>
				</div>
			</div>
		</div>
	</xsl:template>


	<xsl:template match="code-name" mode="card">
		<li>
			<span class="value">
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
				<i class="fa-solid fa-circle old-version" title="{$oldVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'maintained'">
				<i class="fa-solid fa-circle maintained-version" title="{$maintainedVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'current'">
				<i class="fa-solid fa-circle-check current-version" title="{$currentVersion}"></i>
			</xsl:when>
			<xsl:when test="@status = 'future'">
				<i class="fa-solid fa-circle future-version" title="{$futureVersion}"></i>
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

</xsl:stylesheet>
