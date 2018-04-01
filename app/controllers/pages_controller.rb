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
    
    indexer = HtmlIndexer.new(open(page.url))
    page.h1 = indexer.get_content_of('h1')
    page.h2 = indexer.get_content_of('h2')
    page.h3 = indexer.get_content_of('h3')
    page.link = indexer.get_links

    if page.save
      jsonapi_render json: page, status: :created
    else
      jsonapi_render_errors json: page, status: :unprocessable_entity
    end
  end
end
