#encoding: UTF-8

module TitleHelper
  def title(title)
    t = 'La República Ciudadana'
    t = "#{title} | " + t if not title.nil? and not title.empty?
    content_tag :title, t
  end
end
