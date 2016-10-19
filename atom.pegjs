// Atom only now...

ATOM
  = _ value:value _ { return value; }

_ = [\t\n\r ]*
left_arrow = _ "<" _
right_arrow = _ ">" _
quotation = _ '"' _
equal = _ "=" _
backslash = _ "/" _
begin_cdata = _ "<![CDATA[" _
end_cdata = _ "]]>"


ATOM_text
  = _ value:value _ {
      return value;
    }


value
  = Multi / Line / Cdata / Content


Multi
  = StartTag:StartTag
    content: (
      head:value
      tail:value* {
        return [head].concat(tail);
      }
    )
    EndTag:EndTag {
      if(Object.keys(StartTag)[0] !== EndTag) {
        throw new Error(`StartTag ${StartTag[0]} no equal to EndTag ${EndTag}`);
      }
      // TODO 覆盖问题
      if(StartTag[EndTag]) {
        content.reduce((prev, curr) => Object.assign(prev, curr), StartTag[EndTag]);
        return StartTag;
      } else {
        // TODO content 冲突问题
        if(content.length === 1 && Object.keys(content[0]).toString() === 'content')  return {[EndTag]: content[0].content};
        return {[EndTag]:  content.reduce((prev, curr) => Object.assign(prev, curr))};
      }
    }


StartTag "STARTTAG"
  = left_arrow 
    key:TagName
    _
    members:
    (
      head:keyword
      tail:(_ m:keyword { return m; })*
      {
        return [head].concat(tail).reduce((prev, curr) => Object.assign(prev, curr));
      }
    )?
    right_arrow
    {
      return {[key]: members === null ? '' : members.length === 1 ? members[0] : members};
    }


EndTag "ENDTAG"
  = left_arrow
     backslash
     TagName:TagName
     right_arrow
     { return TagName }


Line "LINE"
  = left_arrow 
    key:TagName
    _
    members:(
      head:keyword
      tail:(_ m:keyword { return m; })*
      {
        return [head].concat(tail).reduce((prev, curr) => Object.assign(prev, curr));
      }
    )?
    backslash
    right_arrow
    {
      return {[key]: members === null ? '' : members.length === 1 ? members[0] : members};
    }


// /x3C "<![CDATA[" /\x3C\x3C\3E/ TODO: 匹配 <![CDATA[ 和 ]]> 之间的内容 =.=
Cdata "CDATA"
  = begin_cdata
    chars:char*
    end_cdata
    {
      return { content: chars.join('') }
    }


Content "CONTENT" 
  =  chars: [^<]+ { return { content: chars.join('') } }


keyword
  = name:TagName
    equal 
    value:string
    {
      return { [name]: value }
    }


TagName = chars:[a-zA-Z_]+ { return chars.join(""); }
TagText = chars:[^<]+ { return chars.join(""); }


// string & char
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
content = [^\0-\x1F<]
unescaped = [^\0-\x1F\x22\x5C]
HEX = [0-9a-f]i
