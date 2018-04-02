require 'rails_helper'

RSpec.describe Page, type: :model do
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
  end

  describe 'content accessor' do
    context 'when content is empty' do
      subject { Page.new(url: 'http://example.com/')}
      
      it 'should have empty h1 contents' do
        expect(subject.h1).to be_nil 
      end

      it 'should have empty h2 contents' do
        expect(subject.h2).to be_nil 
      end

      it 'should have empty h3 contents' do
        expect(subject.h3).to be_nil 
      end

      it 'should have empty link contents' do
        expect(subject.link).to be_nil 
      end
    end
    
    context 'when content is not empty' do
      subject do
        Page.new(
           url: 'http://example.com/',
           h1: ['one'], 
           h2: ['one', 'two'], 
           h3: ['one', 'two', 'three'], 
           link: ['http://first.com', 'http://second.com']
        )
      end
      
      it 'should have value for h1 content' do
        expect(subject.h1).to eq(["one"]) 
      end

      it 'should have value for h2 content' do
        expect(subject.h2).to eq(["one", "two"]) 
      end

      it 'should have value for h3 content' do
        expect(subject.h3).to eq(["one", "two", "three"])
      end

      it 'should have value for link content' do
        expect(subject.link).to eq(['http://first.com', 'http://second.com'])
      end
    end
  end
  
end
