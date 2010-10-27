class FormatType
  def self.types
    @@format_types
  end
  
  def self.find(name)
    type = @@format_types[name]
    type = @@format_types['xhtml'] unless type
    type
  end
  
  def self.register type
    @@format_types ||= {}
    @@format_types[type.name] = type
    type
  end
  
  attr_accessor :name
  
  def initialize name
    @name = name
  end
  
  def format(text)
    raise 'unimplemented.'
  end
end

xhtml = FormatType.new('xhtml')
def xhtml.format(text)
  text
end
FormatType.register(xhtml)

markdown = FormatType.new('markdown')
def markdown.format(text)
  require 'bluecloth'
  BlueCloth.new(text).to_html
end
FormatType.register(markdown)

textile = FormatType.new('textile')
def textile.format(text)
  require 'redcloth'
  RedCloth.new(text).to_html
end
FormatType.register(textile)

hatena = FormatType.new('hatena')
def hatena.format(text)
  require 'hparser'
  require 'hparser_ext'
  hatena = HParser::Parser.new(
    HParser::Parser.default_parser, 
    HParser::Inline::Parser.new([HParser::Inline::Text])
  ).parse(text)
  hatena.map{|b| b.to_html}.join("\n")
end
FormatType.register(hatena)


