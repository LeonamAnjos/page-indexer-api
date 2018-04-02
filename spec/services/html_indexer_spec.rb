require 'rails_helper'

RSpec.describe HtmlIndexer, type: :service do
    subject { HtmlIndexer.new(html)}
    let(:html) { file_fixture("simple_page.html").read }
    let(:h1) { ["First Heading", "This is heading 1 (1)"] }
    let(:h2) { ["This is heading 2 (1.1)", "This is heading 2 (1.2)"] }
    let(:h3) { ["This is heading 3 (1.1.1)", "This is heading 3 (1.2.1)", "This is heading 3 (1.2.2)"] }
    let(:links) { ["https://github.com/LeonamAnjos", "https://www.example.com"] }

    describe '#get_content_of' do
        it 'should return only h1 contents' do
            expect(subject.get_content_of('h1')).to match_array(h1)
        end  
      
        it 'should return only h2 contents' do
            expect(subject.get_content_of('h2')).to match_array(h2)
        end  

        it 'should return only h3 contents' do
            expect(subject.get_content_of('h3')).to match_array(h3)
        end  
    end

    describe '#get_links' do
        it 'should return only links' do
            expect(subject.get_links).to match_array(links)
        end  
    end
end
