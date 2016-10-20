# 基于 PEG.js 的 XML 解析器

目前仅支持 Atom 格式解析，还在施工中...

输入：

```XML
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title type="text">博客园_Franky</title>
  <subtitle type="text">123</subtitle>
  <id>uuid:4ca0426d-fc98-4b4b-82b3-37062b1deafb;id=4346</id>
  <updated>2016-07-07T09:23:36Z</updated>
  <author>
    <name>Franky</name>
    <uri>http://www.cnblogs.com/_franky/</uri>
  </author>
  <generator>feed.cnblogs.com</generator>
  <entry>
    <id>http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html</id>
    <title type="text">从ES5 的 函数声明与函数表达式说起. - Franky</title>
    <summary type="text">我们先从阿灰 的蛋疼的例子开始.demo1： function test() { var x = 1; with ({x: 2}) { eval('function foo() { console.log(x); }'); eval('var bar = function() { console.l...</summary>
    <published>2012-12-12T17:16:00Z</published>
    <updated>2012-12-12T17:16:00Z</updated>
    <author>
      <name>Franky</name>
      <uri>http://www.cnblogs.com/_franky/</uri>
    </author>
    <link rel="alternate" href="http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html" />
    <link rel="alternate" type="text/html" href="http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html" />
    <content type="html">【摘要】我们先从阿灰 的蛋疼的例子开始.demo1： function test() { var x = 1; with ({x: 2}) { eval('function foo() { console.log(x); }'); eval('var bar = function() { console.l... &lt;a href="http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html" target="_blank"&gt;阅读全文&lt;/a&gt;</content>
  </entry>
</feed>
```

解析生成:

```json
{
   "version": "1.0",
   "encoding": "utf-8",
   "feed": {
      "xmlns": "http://www.w3.org/2005/Atom",
      "title": {
         "type": "text",
         "content": "博客园_Franky"
      },
      "subtitle": {
         "type": "text",
         "content": "123"
      },
      "id": "uuid:4ca0426d-fc98-4b4b-82b3-37062b1deafb;id=4346",
      "updated": "2016-07-07T09:23:36Z",
      "author": {
         "name": "Franky",
         "uri": "http://www.cnblogs.com/_franky/"
      },
      "generator": "feed.cnblogs.com",
      "entry": {
         "id": "http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html",
         "title": {
            "type": "text",
            "content": "从ES5 的 函数声明与函数表达式说起. - Franky"
         },
         "summary": {
            "type": "text",
            "content": "我们先从阿灰 的蛋疼的例子开始.demo1： function test() { var x = 1; with ({x: 2}) { eval('function foo() { console.log(x); }'); eval('var bar = function() { console.l..."
         },
         "published": "2012-12-12T17:16:00Z",
         "updated": "2012-12-12T17:16:00Z",
         "author": {
            "name": "Franky",
            "uri": "http://www.cnblogs.com/_franky/"
         },
         "link": {
            "rel": "alternate",
            "type": "text/html",
            "href": "http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html"
         },
         "content": {
            "type": "html",
            "content": "【摘要】我们先从阿灰 的蛋疼的例子开始.demo1： function test() { var x = 1; with ({x: 2}) { eval('function foo() { console.log(x); }'); eval('var bar = function() { console.l... &lt;a href=\"http://www.cnblogs.com/_franky/archive/2012/12/13/2815624.html\" target=\"_blank\"&gt;阅读全文&lt;/a&gt;"
         }
      }
   }
}
```
