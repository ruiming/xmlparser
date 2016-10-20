// Atom only now...
// TODO: 覆盖问题和空标签问题

ATOM
  = _ value:value _ { return value; }

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

ATOM_text
  = 
    _ value:value _ 
    {
      console.log(value);
      return value;
    }


value
  = head:head
    atom:atom {
      return Object.assign(head, atom);
    }


atom
  = Multi / Line / Cdata / Content


// Start
head
  = begin_xml
    members:
    (
      head:keyword
      tail:(_ m:keyword { return m; })*
      {
        return [head].concat(tail).reduce((prev, curr) => Object.assign(prev, curr));
      }
    )
    end_xml
    {
      return members;
    }


Multi
  = StartTag:StartTag
    content: (
      head:atom
      tail:atom* {
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


// Match CDATA
Cdata "CDATA"
  = begin_cdata
    text:CdataText
    end_cdata
    { return { content: text.join('') } }


CdataText
  = x:(&(. (!"]]>" .)* "]]>").)* { return x.map(y => y[1])}


// Match Content(no CDATA)
Content "CONTENT"
  = text: [^<]+
    { return { content: text.join('') } }


// Match keyword like a="b"
keyword
  = name:TagName
    equal 
    atom:string
    {
      return { [name]: atom }
    }


// Match TagName and Tagatom
TagName = chars:[a-zA-Z_:?]+ { return chars.join('').replace(/:/g, '-').replace(/\?/, '') }
Tagatom = chars:[^<]+ { return chars.join(""); }


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
