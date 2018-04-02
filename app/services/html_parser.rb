class HtmlParser
    attr_reader :html

    def initialize(html)
        @html = Nokogiri::HTML(html)
    end

    def get_content_of(tag)
        html.css(tag).children.to_a.map(&:to_s)
    end

    def get_links
        html.css('a').map { |el| el.attribute('href').value }
    end
end