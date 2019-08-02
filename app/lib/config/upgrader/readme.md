Upgrade configuration for user who installed the app from a non-store environment.

To indicate an update is a critical one in xml
```xml
 <item>
            <title>Version 0.3.3</title>
            <description>修复崩溃</description>
            <pubDate>2019/07/11 20:00</pubDate>
            <sparkle:tags>
                <sparkle:criticalUpdate/>
            </sparkle:tags>
            <enclosure url="https://github.com/edwardez/BangumiN/releases"
                       sparkle:version="0.3.3" sparkle:os="android"/>
</item>
```