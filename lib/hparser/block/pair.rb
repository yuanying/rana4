# Author:: MIZUNO Hiroki (hiroki1124@gmail.com)
# Copyright:: Copyright (c) 2006 MIZUNO Hiroki
# License::   Distributes under the same terms as Ruby

require 'hparser/util/parser'
module HParser
  module Block
    # Some formats have common structure.
    # 
    # Qutoe is defined as
    #  >>
    #  quoted string
    #  <<
    #
    # Pre is defiend as
    #  >|
    #  plain text
    #  |<
    #
    # In short,some format is different in begining/ending string.
    # So this class have basic structure for that format.
    #
    # Remark:Strictly,quote is defined as "from the line that contain only '>>' to
    # the line that contain only '<<'"
    class Pair
      def self.get(scanner,from,to)
        from_q = Regexp.quote from
        to_q = Regexp.quote to
        if scanner.scan(/^#{from_q}$/)
          content = ''
          until scanner.scan(/^#{to_q}$/) do
            content += "\n"+ scanner.scan(/.*/)
          end
          return content.strip
        end
      end

      # make parser by begin/end-ing string
      def self.spliter(from,to)
        module_eval <<-"END"
        def self.parse(scanner,inlines)
          content = get(scanner,"#{from}","#{to}")
          if content then
            self.new inlines.parse(content)
          else
            nil
          end
        end
        END
      end

      attr_reader :content
      def initialize(content)
        @content = content
      end
      
      def ==(o)
        self.class == o.class and self.content == o.content
      end
    end
    
    class LastContainedPair < Pair
      def self.get(scanner,from,to)
        from_q = Regexp.quote from
        to_q = Regexp.quote to
        if scanner.scan(/^#{from_q}$/)
          content = ''
          tq = /#{to_q}$/
          while true do
            str = scanner.scan(tq)
            if str
              content += str.slice(0...str.index(tq))
              break
            else
              str = scanner.scan(/.*/)
              if str
                content += str + "\n"
              end
            end
          end
          return content.strip
        end
      end
    end 
  end
end

