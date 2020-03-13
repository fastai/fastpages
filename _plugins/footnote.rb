module Jekyll
    class FootNoteTag < Liquid::Tag
  
      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end
  
      def render(context)
        "<sup id='fnref-#{@text}' class='footnote-ref'><a href='#fn-#{@text}'>#{@text}</a></sup>"
      end
    end
  end
  
Liquid::Template.register_tag('fn', Jekyll::FootNoteTag)
