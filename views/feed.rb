class Few
  module Views
    class Feed < Mustache
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
        [
          {
            :title => "DON'T",
            :description => "Shalom, Avi! Smart of you to get the sold-separately chinstrap and visor attachments for your yarmulke, because on the Gaza Strip they play Hacky Sack with rubble.",
            :link => "http://www.viceland.com/int/dd.php?id=2394",
            :timestamp => Time.parse("Apr 30, 2010").rfc822
          }
        ]
      end
    end
  end
end