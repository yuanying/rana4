#!/usr/bin/env ruby
#
#  Created by Yuanying on 2007-08-02.
#  Copyright (c) 2007. All rights reserved.
# tiny fixes for hparser.
# author: sasaki.takeru@gmail.com

require "hparser"

module HParser
  class Parser
    alias :parse_orig :parse
    def parse str
      str = str.dup
      str.gsub!(/\r\n/, "\n")
      str.gsub!(/\r/,   "\n")
      parse_orig str
    end
  end
  module Block
    class SuperPre
      def html_content
        content = self.content
        content.gsub!(/&/, "&amp;")
        content.gsub!(/</, "&lt;")
        content.gsub!(/>/, "&gt;")
        content
      end
    end
  end
  module Inline
    URL_PATTERN = /(<\w+.*?>|[^=!:'"\/]|^)((?:http[s]?:\/\/)|(?:www\.))([^\s<]+\/?)([[:punct:]]|\s|<|$)/
    def Url.parse(scanner)
      if scanner.scan(URL_PATTERN) then
        Url.new scanner.matched
      end
    end

    MY_ID_FORMAT = "[a-z0-9][a-z0-9\-]*[a-z0-9]"
    def HatenaId.parse(scanner)
      if scanner.scan(/id:#{MY_ID_FORMAT}/) then
        HatenaId.new scanner.matched[3..-1]
      end
    end
    class HatenaId
      def to_html
        %(<a href="/account/id/#{self.name}">id:#{self.name}</a>)
      end
    end
    class Parser
      #alias :join_text_orig :join_text
      #def join_text(nodes)
      #  return nodes unless nodes
      #  join_text_orig(nodes)
      #end
    end
  end
end
