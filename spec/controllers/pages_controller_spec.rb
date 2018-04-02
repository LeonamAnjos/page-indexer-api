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

    describe '#create' do
        subject(:create) { post :create, params: params, headers: headers, as: :json}
        let(:params) do
            {
                'data' => {
                  'type' => 'pages',
                  'attributes' => {
                    'url' => 'www.bah.com'
                  }
                }
            }
        end
        let(:headers) do
            {
                'CONTENT_TYPE' => JSONAPI::MEDIA_TYPE,
                'ACCEPT' => JSONAPI::MEDIA_TYPE
            }
        end
        let(:html) { file_fixture("simple_page.html").read }
        let(:html_indexed) do
            {
                "id" => "1", 
                "type" => "pages", 
                "links" => {
                    "self" => "http://test.host/pages/1"
                }, 
                "attributes" => {
                        "url"=>"www.bah.com", 
                        "h1"=>["First Heading", "This is heading 1 (1)"], 
                        "h2"=>["This is heading 2 (1.1)", "This is heading 2 (1.2)"], 
                        "h3"=>["This is heading 3 (1.1.1)", "This is heading 3 (1.2.1)", "This is heading 3 (1.2.2)"],
                        "link"=>["https://www.example.com", "https://github.com/LeonamAnjos"]
                }
            }
        end

        before do
            expect(controller).to receive(:open).once.with("www.bah.com").and_return(html)
        end

        it 'should create a page' do
            create
            expect(response.status).to eq 201
            expect(response_data).to eq html_indexed
        end
    end
end
