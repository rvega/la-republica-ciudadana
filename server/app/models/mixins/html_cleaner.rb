module Mixins
  module HtmlCleaner
    protected
    def clean(html)
      elements = %w(b i u blockquote a span br ul li ol)
      attributes = {
        'a' => %w(href title target rel),
        'blockquote' => %w(style), 
        'span' => ['class']
      }
      add_attributes = {'a' => {'rel' => "nofollow"}}
      protocols = {'a' => {'href'=>%w(ftp http https mailto :relative)}}

      html = Sanitize.clean(
        html, 
        :elements => elements, 
        :attributes => attributes, 
        :protocols => protocols,
        :add_attributes => add_attributes
      )

      html
    end
  end
end
