require 'rails_helper'

RSpec.describe HtmlIndexer, type: :service do
    subject { HtmlIndexer.new(html)}
    let(:html) { file_fixture("simple_page.html").read }

    describe '#get_content_of' do
        it 'should return only h1 contents' do
            expect(subject.get_content_of('h1')).to contain_exactly("First Heading", "This is heading 1 (1)")
        end  
      
        it 'should return only h2 contents' do
            expect(subject.get_content_of('h2')).to contain_exactly("This is heading 2 (1.1)", "This is heading 2 (1.2)")
        end  

        it 'should return only h3 contents' do
            expect(subject.get_content_of('h3')).to contain_exactly("This is heading 3 (1.1.1)", "This is heading 3 (1.2.1)", "This is heading 3 (1.2.2)")
        end  
    end

    describe '#get_links' do
        it 'should return only links' do
            expect(subject.get_links).to contain_exactly("https://github.com/LeonamAnjos", "https://www.example.com")
        end  
    end
end
