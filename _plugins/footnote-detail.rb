module Jekyll
    module AssetFilter
      def fndetail(input, id)
        "<div class='footnotes'><p id='fn-#{id}'>#{id}. #{input}<a href='#fnref-#{id}' class='footnote footnotes'>↩</a></p></div>"
      end
    end
  end
  
Liquid::Template.register_filter(Jekyll::AssetFilter)
