require 'open-uri'
require 'cgi'

class Few
  module Feeds
    class ViceDosAndDonts
      def title
        "VICE DOs & DON'Ts"
      end
      
      def description
        "VICE magazine's DOs and DON'Ts feature displays candid photographs of strangers in public places accompanied by commentary either ridiculing or praising the fashion and perceived sensibility of the people in the photos. Some DOs and DON'Ts do not seriously address fashion, but merely couple the photos with humorous commentary."
      end
      
      def link
        "http://www.viceland.com/int/dos.php"
      end
      
      def items
        current_id = starting_id
             
        items = []
        
        10.times do
          items << scrape_one(current_id)
          current_id -= 1
        end
        
        items
      end
      
      def starting_id
        @current_id ||= begin
          body = open("http://www.viceland.com/int/dos.php").read
          body.scan(%r|dos_donts/(\d+)/icon.jpg|).flatten.map {|e| e.to_i }.sort.last
        end
      end
      
      def scrape_one(id)
        url  = "http://www.viceland.com/int/dd.php?id=#{id}"
        body = open(url).read
        
        title     = body.match(/<h1>(.*?)<\/h1>/)[1]
        caption   = body.scan(%r|<td\s+valign='top'\s+align='left'>([^>]+)<|mi).flatten.first.strip
        image_url = "http://scs.viceland.com/img/dos_donts/#{id}/main.jpg"
        
        description = "&lt;img src='#{image_url}'&gt;&lt.br /&gt;&lt;p&gt;#{caption}&lt;/p&gt;"
        
        timestamp = Time.parse(body.match(/on ([^<]+) <i>wrote:/)[1]).rfc822 rescue Time.now.rfc822
        
        {:title => title, :link => url, :description => description, :timestamp => timestamp}
      end
    end
  end
end