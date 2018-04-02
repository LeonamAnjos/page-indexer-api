require 'open-uri'

class PagesController < ApplicationController

  # GET /pages
  def index
    pages = Page.all
    jsonapi_render json: pages
  end

  # POST /pages
  def create
    page = Page.new(resource_params)

    if Page.exists?(url: page.url)
      jsonapi_render_errors json: error_url_already_exists, status: :unprocessable_entity
      return
    end

    content = open(page.url)
    parser = HtmlParser.new(content)
    page.h1 = parser.contents_of_tag('h1')
    page.h2 = parser.contents_of_tag('h2')
    page.h3 = parser.contents_of_tag('h3')
    page.link = parser.links

    if page.save
      jsonapi_render json: page, status: :created
    else
      jsonapi_render_errors json: page, status: :unprocessable_entity
    end
  end

  private

    def error_url_already_exists
      [{
        title: "has already been taken",
        detail: "Url has already been taken",
        id: "url#taken",
        code: "100",
        source: { pointer: "/data/attributes/url" },
        status: "422"
      }]
    end
end
