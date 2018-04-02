require 'rails_helper'

RSpec.describe HtmlParser, type: :service do
    subject(:indexer) { HtmlParser.new(html) }
    let(:html) { file_fixture("simple_page.html").read }
    
    describe '#contents_of_tag' do
        subject { indexer.contents_of_tag(tag) }
        
        context 'when exists tag h1' do
            let(:tag) { 'h1' }
            let(:h1) { ["First Heading", "This is heading 1 (1)"] }

            it { is_expected.to match_array h1}
        end

        context 'when exists tag h2' do
            let(:tag) { 'h2' }
            let(:h2) { ["This is heading 2 (1.1)", "This is heading 2 (1.2)"] }
            
            it { is_expected.to match_array h2}
        end
        
        context 'when exists tag h3' do
            let(:tag) { 'h3' }
            let(:h3) do 
                [
                 "This is heading 3 (1.1.1)",
                 "This is heading 3 (1.2.1)",
                 "This is heading 3 (1.2.2)"
                ]
            end

            it { is_expected.to match_array h3 }
        end

        context 'when tag does NOT exist' do
            let(:tag) { 'inexistentTag' }

            it { is_expected.to match_array [] }
        end
    end

    describe '#links' do
        subject { indexer.links }
    
        context 'when exists link' do
            let(:links) { ["https://github.com/LeonamAnjos", "https://www.example.com"] }
        
            it { is_expected.to match_array links }
        end
    end
end
