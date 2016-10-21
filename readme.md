# xmlparser

A xmlparser parse xml-like data and turn it to a JavaScript Object.

## Usage

You can copy the code from the `atom.pegjs` to this website [http://pegjs.org/online](http://pegjs.org/online) to test online.

I recommend not to used it in production now, for it is not tested enough as well as not finished yet.


## Features

- No overwrite

  If there is more than one node which has the same key name, it will auto be combined as an array and there is no overwrite problem.

- Value within the tag

  The html or text within the tag that has more than one attribute will be turn into an object like `{ value: xxx }`. For example, parse `<summary type="html">123</summary>` will return `{ summary: { type: "html", "value": 123}}`. And If there is no attribute exists in the tag, for example `{<title>Ruiming&#39;s Blog</title>}` will return `{ title: "Ruiming&#39;s Blog" }`.

- Based on PEG.js

  Means that it is generic, but both PEG.js and this project are not formally published yet.


## Example

### Atom

**input：**

```XML
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title>Ruiming&#39;s Blog</title>
  <link href="/atom.xml" rel="self"/>
  <link href="https://ruiming.github.io/"/>
  <updated>2016-10-14T11:54:55.587Z</updated>
  <id>https://ruiming.github.io/</id>
  <author>
    <name>Ruiming</name>
    <email>ruiming.zhuang@gmail.com</email>
  </author>
  <generator uri="http://hexo.io/">Hexo</generator>
  <entry>
    <title>aaabbbccc</title>
    <link href="https://ruiming.github.io/"/>
    <id>https://ruiming.github.io/</id>
    <published>2016-10-14T11:29:05.000Z</published>
    <updated>2016-10-14T11:54:55.587Z</updated>
    <content type="html"><![CDATA[<p>123456</p><a href="https://ruiming.github.io">Test</a>]]></content>
    <summary type="html">&lt;p&gt;TestTest&lt;/p&gt;</summary>
      <category term="Angular" scheme="https://ruiming.github.io/tags/Angular/"/>
      <category term="JavaScript" scheme="https://ruiming.github.io/tags/JavaScript/"/>
      <category term="JWT" scheme="https://ruiming.github.io/tags/JWT/"/>
      <category term="Koa" scheme="https://ruiming.github.io/tags/Koa/"/>
  </entry>
</feed>
```

**output:**

```json
{
   "version": "1.0",
   "encoding": "utf-8",
   "feed": {
      "xmlns": "http://www.w3.org/2005/Atom",
      "title": "Ruiming&#39;s Blog",
      "link": [
         {
            "href": "/atom.xml",
            "rel": "self"
         },
         {
            "href": "https://ruiming.github.io/"
         }
      ],
      "updated": "2016-10-14T11:54:55.587Z",
      "id": "https://ruiming.github.io/",
      "author": {
         "name": "Ruiming",
         "email": "ruiming.zhuang@gmail.com"
      },
      "generator": {
         "uri": "http://hexo.io/",
         "value": "Hexo"
      },
      "entry": {
         "title": "aaabbbccc",
         "link": {
            "href": "https://ruiming.github.io/"
         },
         "id": "https://ruiming.github.io/",
         "published": "2016-10-14T11:29:05.000Z",
         "updated": "2016-10-14T11:54:55.587Z",
         "content": {
            "type": "html",
            "value": "<p>123456</p><a href=\"https://ruiming.github.io\">Test</a>"
         },
         "summary": {
            "type": "html",
            "value": "&lt;p&gt;TestTest&lt;/p&gt;"
         },
         "category": [
            {
               "term": "Angular",
               "scheme": "https://ruiming.github.io/tags/Angular/"
            },
            {
               "term": "JavaScript",
               "scheme": "https://ruiming.github.io/tags/JavaScript/"
            },
            {
               "term": "JWT",
               "scheme": "https://ruiming.github.io/tags/JWT/"
            },
            {
               "term": "Koa",
               "scheme": "https://ruiming.github.io/tags/Koa/"
            }
         ]
      }
   }
}
```

### RSS

**input:**

```xml
<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
	xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
	>

<channel>
	<title>Web前端 腾讯AlloyTeam  Blog &#124; 愿景: 成为地球卓越的Web团队！</title>
	<atom:link href="http://www.alloyteam.com/feed/" rel="self" type="application/rss+xml" />
	<link>http://www.alloyteam.com</link>
	<description>腾讯全端 AlloyTeam 团队 Blog</description>
	<lastBuildDate>Fri, 21 Oct 2016 02:45:51 +0000</lastBuildDate>
	<language>zh-CN</language>
	<sy:updatePeriod>hourly</sy:updatePeriod>
	<sy:updateFrequency>1</sy:updateFrequency>
	<generator>http://wordpress.org/?v=4.3.1</generator>
	<item>
		<title>你所需要知道的AC2016——倒数3天</title>
		<link>http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/</link>
		<comments>http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/#comments</comments>
		<pubDate>Thu, 20 Oct 2016 12:36:53 +0000</pubDate>
		<dc:creator><![CDATA[TAT.Johnny]]></dc:creator>
				<category><![CDATA[团队]]></category>

		<guid isPermaLink="false">http://www.alloyteam.com/?p=11383</guid>
		<description><![CDATA[经过了前期踊跃的报名（已超过2000人报名），AC2016即将在10月23日盛大举行。什么，抢不到邀请码？别着 [&#8230;]]]></description>
		<wfw:commentRss>http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/feed/</wfw:commentRss>
		<slash:comments>2</slash:comments>
		</item>
		<item>
		<title>AC2016讲师专访——郭林烁 joey</title>
		<link>http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/</link>
		<comments>http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/#comments</comments>
		<pubDate>Wed, 19 Oct 2016 13:54:11 +0000</pubDate>
		<dc:creator><![CDATA[TAT.Johnny]]></dc:creator>
				<category><![CDATA[团队]]></category>

		<guid isPermaLink="false">http://www.alloyteam.com/?p=11372</guid>
		<description><![CDATA[讲师介绍 郭林烁 joey 腾讯AlloyTeam前端工程师 主要负责了手机 QQ、PC QQ 及花样直播等业 [&#8230;]]]></description>
		<wfw:commentRss>http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/feed/</wfw:commentRss>
		<slash:comments>1</slash:comments>
		</item>
	</channel>
</rss>
```

**output:**

```json
{
   "version": "1.0",
   "encoding": "UTF-8",
   "rss": {
      "version": "2.0",
      "xmlns-content": "http://purl.org/rss/1.0/modules/content/",
      "xmlns-wfw": "http://wellformedweb.org/CommentAPI/",
      "xmlns-dc": "http://purl.org/dc/elements/1.1/",
      "xmlns-atom": "http://www.w3.org/2005/Atom",
      "xmlns-sy": "http://purl.org/rss/1.0/modules/syndication/",
      "xmlns-slash": "http://purl.org/rss/1.0/modules/slash/",
      "channel": {
         "title": "Web前端 腾讯AlloyTeam  Blog &#124; 愿景: 成为地球卓越的Web团队！",
         "atom-link": {
            "href": "http://www.alloyteam.com/feed/",
            "rel": "self",
            "type": "application/rss+xml"
         },
         "link": "http://www.alloyteam.com",
         "description": "腾讯全端 AlloyTeam 团队 Blog",
         "lastBuildDate": "Fri, 21 Oct 2016 02:45:51 +0000",
         "language": "zh-CN",
         "sy-updatePeriod": "hourly",
         "sy-updateFrequency": "1",
         "generator": "http://wordpress.org/?v=4.3.1",
         "item": [
            {
               "title": "你所需要知道的AC2016——倒数3天",
               "link": "http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/",
               "comments": "http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/#comments",
               "pubDate": "Thu, 20 Oct 2016 12:36:53 +0000",
               "dc-creator": "TAT.Johnny",
               "category": "团队",
               "guid": {
                  "isPermaLink": "false",
                  "value": "http://www.alloyteam.com/?p=11383"
               },
               "description": "经过了前期踊跃的报名（已超过2000人报名），AC2016即将在10月23日盛大举行。什么，抢不到邀请码？别着 [&#8230;]",
               "wfw-commentRss": "http://www.alloyteam.com/2016/10/what-you-need-to-know-ac2016-the-last-3-days/feed/",
               "slash-comments": "2"
            },
            {
               "title": "AC2016讲师专访——郭林烁 joey",
               "link": "http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/",
               "comments": "http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/#comments",
               "pubDate": "Wed, 19 Oct 2016 13:54:11 +0000",
               "dc-creator": "TAT.Johnny",
               "category": "团队",
               "guid": {
                  "isPermaLink": "false",
                  "value": "http://www.alloyteam.com/?p=11372"
               },
               "description": "讲师介绍 郭林烁 joey 腾讯AlloyTeam前端工程师 主要负责了手机 QQ、PC QQ 及花样直播等业 [&#8230;]",
               "wfw-commentRss": "http://www.alloyteam.com/2016/10/interview-ac2016-instructor-lin-guo-shuo-joey/feed/",
               "slash-comments": "1"
            }
         ]
      }
   }
}
```
