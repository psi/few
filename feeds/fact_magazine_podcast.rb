require 'open-uri'
require 'htmlentities'

class Few
  module Feeds
    class FactMagazinePodcast
      def title
        "FACT magazine Podcast"
      end
      
      def description
        "it's a podcast, stupid."
      end
      
      def link
        "http://www.factmag.com/category/mixes/"
      end
      
      def items
        #mixes_url = "http://www.factmag.com/category/mixes/feed/"
        [{
          :title => "FACT mix 156: Kode9",
          :description => "FACT mix 156: Kode9",
          :link => "http://www.factmag.com/2010/06/07/fact-mix-156-kode9/",
          :timestamp => Time.now,
          :enclosure_url => "http://mp3.factmagazine.co.uk/FACT%20Mix%20156%20-%20Kode9%20(Jun%20'10).mp3",
          :enclosure_content_type => "audio/mpeg",
          :enclosure_length => "75120040"
        }]
      end
      
      def starting_id
        @current_id ||= begin
          body = open("http://www.viceland.com/int/dos.php").read
          body.scan(%r|dos_donts/(\d+)/icon.jpg|).flatten.map {|e| e.to_i }.sort.last
        end
      end
      
      def scrape_one(id)
        coder = HTMLEntities.new

        url  = "http://www.viceland.com/int/dd.php?id=#{id}"
        body = open(url).read
        
        title     = body.match(/<h1>(.*?)<\/h1>/)[1]
        caption   = body.scan(%r|<td\s+valign='top'\s+align='left'>(.*?)</td>|mi).flatten.first.strip
        image_url = "http://scs.viceland.com/img/dos_donts/#{id}/main.jpg"

        caption = coder.decode(caption)
        caption = coder.encode(caption, :basic, :decimal)
        
        description = "&lt;img src='#{image_url}'&gt;&lt;br /&gt;&lt;p&gt;#{caption}&lt;/p&gt;"
        
        timestamp = Time.parse(body.match(/on ([^<]+) <i>wrote:/)[1]).rfc822 rescue Time.now.rfc822
        
        {:title => title, :link => url, :description => description, :timestamp => timestamp}
      end
    end
  end
end
