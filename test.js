const atom = require('./atom');
const rss = `
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
    <title>关于前后端分离鉴权的思考</title>
    <link href="https://ruiming.github.io/2016/10/14/%E5%85%B3%E4%BA%8E%E5%89%8D%E5%90%8E%E7%AB%AF%E5%88%86%E7%A6%BB%E9%89%B4%E6%9D%83%E7%9A%84%E6%80%9D%E8%80%83/"/>
    <id>https://ruiming.github.io/2016/10/14/关于前后端分离鉴权的思考/</id>
    <published>2016-10-14T11:29:05.000Z</published>
    <updated>2016-10-14T11:54:55.587Z</updated>
    <content type="html"><![CDATA[<p>123456</p><a href="https://ruiming.github.io">Test</a>]]></content>
    <summary type="html">
      &lt;p&gt;前后端分离项目的 Token 存储问题由来已久，有的人存 Cookie 有的人存 LocalStorage 或 SessionStorage，最近刚把 RSS 订阅器项目的鉴权问题做好，感觉算是目前比较稳妥安全的方案了，分享一下经验。&lt;/p&gt;
    </summary>
      <category term="安全" scheme="https://ruiming.github.io/categories/%E5%AE%89%E5%85%A8/"/>
      <category term="Angular" scheme="https://ruiming.github.io/tags/Angular/"/>
      <category term="JavaScript" scheme="https://ruiming.github.io/tags/JavaScript/"/>
      <category term="JWT" scheme="https://ruiming.github.io/tags/JWT/"/>
      <category term="Koa" scheme="https://ruiming.github.io/tags/Koa/"/>
  </entry>
</feed>
`

var json = atom.parse(rss);
console.log(json);