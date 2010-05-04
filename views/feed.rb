class Few
  module Views
    class Feed < Mustache
      def initialize        
        @feed = Few::Feeds::ViceDosAndDonts.new
      end
      
      def title
        @feed.title
      end
      
      def description
        @feed.description
      end
      
      def link
        @feed.link
      end
      
      def items
        @feed.items
      end
    end
  end
end