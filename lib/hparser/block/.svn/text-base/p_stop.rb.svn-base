#!/usr/bin/env ruby
#
#  Created by Yuanying on 2007-08-02.
#  Copyright (c) 2007. All rights reserved.

require 'hparser/block/collectable'
require 'hparser/block/pair'
module HParser
  module Block
    # Pre format.
    class PStop < Pair
      include Collectable
      
      def self.get(scanner,from,to)
        from_q = Regexp.quote from
        to_q = Regexp.quote to
        str = scanner.scan(/^#{from_q}/)
        if str
          str.slice!(0..1)
          content = "#{str}\n"
          while true do
            str = scanner.scan(/#{to_q}$/)
            if str
              content += str.slice(0...str.index(/><$/))
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
      
      spliter '><','><'
    end
  end
end