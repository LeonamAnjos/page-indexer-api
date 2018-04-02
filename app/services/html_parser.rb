class HtmlParser
    attr_reader :html

    def initialize(html)
        @html = Nokogiri::HTML(html)
    end

    def contents_of_tag(tag)
        html.css(tag).children.to_a.map(&:to_s)
    end

    def links
        html.css('a').map { |el| el.attribute('href').value }
    end
end