class HtmlSanitizer

  def self.no_html(string)
    ActionView::Base.full_sanitizer.sanitize(string)
  end
end
