require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    subject(:response_data) { JSON.parse(response.body)['data'] }

    describe '#index' do
        subject(:index) { get :index }
    
        it "should return empty" do
            index
            expect(response.status).to eq 200
            expect(response.content_type).to eq "application/vnd.api+json"
            expect(response_data).to be_empty
        end

        it "should return pages" do
            Page.create(url: 'https://www.example.com')
            Page.create(url: 'https://www.example2.com')

            index
            expect(response_data).to contain_exactly(
                {"id"=>"1", "type"=>"pages", "links"=>{"self"=>"http://test.host/pages/1"}, "attributes"=>{"url"=>"https://www.example.com", "h1"=>nil, "h2"=>nil, "h3"=>nil, "link"=>nil}},
                {"id"=>"2", "type"=>"pages", "links"=>{"self"=>"http://test.host/pages/2"}, "attributes"=>{"url"=>"https://www.example2.com", "h1"=>nil, "h2"=>nil, "h3"=>nil,"link"=>nil}}    
            )
        end
    end

end
