# 基于 PEG.js 的 XML 解析器

目前仅支持 Atom 格式解析，还在施工中...

输入：

```XML
<feed xmlns="http://www.w3.org/2005/Atom">
<title>Ruiming's Blog</title>
<link href="/atom.xml" rel="self"/>
<link href="https://ruiming.github.io/"/>
<updated>2016-10-14T11:54:55.587Z</updated>
<id>https://ruiming.github.io/</id>
<author>...</author>
<generator uri="http://hexo.io/">Hexo</generator>
<entry>
<title>关于前后端分离鉴权的思考</title>
<id>https://ruiming.github.io/2016/10/14/关于前后端分离鉴权的思考/</id>
<published>2016-10-14T11:29:05.000Z</published>
<updated>2016-10-14T11:54:55.587Z</updated>
<content type="html">
<![CDATA[
<figure class="highlight json"><table><tr><td class="gutter"><pre><div class="line">1</div><div class="line">2</div><div class="line">3</div><div class="line">4</div></pre></td><td class="code"><pre><div class="line">&#123;</div><div class="line"> <span class="attr">"alg"</span>: <span class="string">"HS256"</span>,</div><div class="line"> <span class="attr">"typ"</span>: <span class="string">"JWT"</span></div><div class="line">&#125;</div></pre></td></tr></table></figure>
]]>
</entry>
</feed>
```

解析生成:

```json
{
   "feed": {
      "xmlns": "http://www.w3.org/2005/Atom",
      "title": "Ruiming's Blog",
      "link": {
         "href": "https://ruiming.github.io/"
      },
      "updated": "2016-10-14T11:54:55.587Z",
      "id": "https://ruiming.github.io/",
      "author": "...",
      "generator": {
         "uri": "http://hexo.io/",
         "content": "Hexo"
      },
      "entry": {
         "title": "关于前后端分离鉴权的思考",
         "id": "https://ruiming.github.io/2016/10/14/关于前后端分离鉴权的思考/",
         "published": "2016-10-14T11:29:05.000Z",
         "updated": "2016-10-14T11:54:55.587Z",
         "content": {
            "type": "html",
            "content": "<figure class=\"highlight json\"><table><tr><td class=\"gutter\"><pre><div class=\"line\">1</div><div class=\"line\">2</div><div class=\"line\">3</div><div class=\"line\">4</div></pre></td><td class=\"code\"><pre><div class=\"line\">&#123;</div><div class=\"line\"> <span class=\"attr\">\"alg\"</span>: <span class=\"string\">\"HS256\"</span>,</div><div class=\"line\"> <span class=\"attr\">\"typ\"</span>: <span class=\"string\">\"JWT\"</span></div><div class=\"line\">&#125;</div></pre></td></tr></table></figure>
"
         }
      }
   }
}
```
