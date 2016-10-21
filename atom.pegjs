// function
{
  // concat({a:1, b:2}, {b:3}) => {a:1, b:[2, 3]}
  function concat(a, b) {
    for(let key of Object.keys(b)) {
      if(a.hasOwnProperty(key)) {
        if(!Array.isArray(a[key]))  a[key] = [a[key]];
        a[key] = a[key].concat(b[key]);
      } else {
        a = Object.assign(a, {[key]: b[key]});
      }
    }
    return a;
  }
}


// Main
XML
  = _ value:value _ { console.log(value); return value; }


value
  = head:head
    content:content {
      return Object.assign(head, content);
    }


content
  = multi / line / cdata / html


// Sign
_ = [\t\n\r ]*
left_arrow = _ "<" _
right_arrow = _ ">" _
quotation = _ '"' _
equal = _ "=" _
backslash = _ "/" _
begin_cdata = _ "<![CDATA[" _
end_cdata = _ "]]>" _
begin_xml = _ "<?xml" _
end_xml = _ "?>" _


// markup
StartTag "STARTTAG"
  = left_arrow 
    key:TagName
    _
    members: (
      head:keyword
      tail:(_ m:keyword { return m; })* {
        return [head].concat(tail).reduce((prev, curr) => Object.assign(prev, curr));
      }
    )?
    right_arrow {
      return { [key]: members === null ? '' : members.length === 1 ? members[0] : members };
    }


EndTag "ENDTAG"
  = left_arrow
    backslash
    TagName:TagName
    right_arrow { 
      return TagName;
    }


TagName = chars:[a-zA-Z_:?]+ { return chars.join('').replace(/:/g, '-').replace(/\?/, ''); }
TagValue = chars:[^<]+ { return chars.join(''); }


// value
head
  = begin_xml
    members: (
      head:keyword
      tail:(_ m:keyword { return m; })* {
        return [head].concat(tail).reduce((prev, curr) => Object.assign(prev, curr));
      }
    )
    end_xml {
      return members;
    }


multi
  = StartTag:StartTag
    content: (
      head:content
      tail:content* {
        return [head].concat(tail);
      }
    )?
    EndTag:EndTag {
      if(Object.keys(StartTag)[0] !== EndTag) {
        throw new Error(`StartTag ${StartTag[0]} no equal to EndTag ${EndTag}`);
      }
      if(StartTag[EndTag]) {
        if(content === null)  StartTag[EndTag].value = '';
        else  {
          content.reduce((prev, curr) => concat(prev, curr), StartTag[EndTag]);
        }
        return StartTag;
      } else {
        if(content.length === 1 && Object.keys(content[0]).toString() === 'value')  return { [EndTag]: content[0].value };
        return { [EndTag]:  content.reduce((prev, curr) => concat(prev, curr)) };
      }
    }


line "LINE"
  = left_arrow 
    key:TagName
    _
    members:(
      head:keyword
      tail:(_ m:keyword { return m; })* {
        return [head].concat(tail).reduce((prev, curr) => concat(prev, curr));
      }
    )?
    backslash
    right_arrow {
      return { [key]: members === null ? '' : members.length === 1 ? members[0] : members };
    }


cdata "CDATA"
  = begin_cdata
    text:text
    end_cdata{ 
      return { value: text.join('') };
    }


text "text"
  = x:(!("]]>") .)* { 
      return x.map(y => y[1]); 
    }


html "html"
  = text: [^<]+ { 
      return { value: text.join('') };
    }


keyword "keyword"
  = k:TagName
    equal 
    v:string {
      return { [k]: v }
    }



// Copy
string
  = quotation chars:char* quotation
    {
      return chars.join("");
    }


char
  = unescaped
  / escape
    sequence:(
    '"'
    / "\\"
    / "/"
    / "b" { return "\b"; }
    / "f" { return "\f"; }
    / "n" { return "\n"; }
    / "r" { return "\r"; }
    / "t" { return "\t"; }
    / "u" digits:$(HEX HEX HEX HEX)
          {
            return String.fromCharCode(parseInt(digits, 16));
          }
    )
    { return sequence; }

escape = "\\"
unescaped = [^\0-\x1F\x22\x5C]
HEX = [0-9a-f]i
