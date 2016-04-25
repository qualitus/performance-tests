<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<xsl:template match="testResults">
  <xsl:variable name="allCount" select="count(/testResults/*)" />
  <xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />
  <xsl:variable name="allSuccessCount" select="count(/testResults/*[attribute::s='true'])" />
  <xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
  <xsl:variable name="allTotalTime" select="sum(/testResults/*/@t)" />
  <xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />

  <build number="{build.number}">
    <statusInfo status="SUCCESS">
      <text action="append"> <xsl:value-of select="$allSuccessCount" /> of <xsl:value-of select="$allCount" /> </text>
      <text action="append"> in <xsl:value-of select="$allTotalTime" /> ms </text>
    </statusInfo>
  </build>
</xsl:template>

</xsl:stylesheet>
