require 'nokogiri'

module Isis
  module Plugin
    class Insult < Isis::Plugin::Base
      TRIGGERS = %w(!insult)

      def respond_to_msg?(msg, speaker)
        @commands = msg.downcase.split
        TRIGGERS.include? @commands[0]
      end

      private

      def response_text
        insult = case rand(0..3)
                 when 0, 1, 2
                   randominsults
                 when 3
                   pirate
                 end
        if @commands[1].nil?
          "#{insult}"
        else
          subject = @commands[1].gsub('@', '')
          "@#{subject} #{insult}"
        end
      end

      def randominsults
        page = Nokogiri.HTML(open('http://www.randominsults.net/'))
        page.css('i').text.strip
      end

      def pirate
        open('http://pir.to/api/insult').string
      end
    end
  end
end
