require 'spec_helper'
require 'json'

GOOGLE_NEWS_BINARY_PATH = './bin/google_news'

RSpec.describe GoogleNews, 'CLI' do
  context 'Get headlines' do
    it 'fetches top headlines with default language' do
      skip
      result = `#{GOOGLE_NEWS_BINARY_PATH} --n 5`
      obj = JSON.parse result

      expect(obj).to be_a(Array)
      expect(obj.length).to eq(5)
      obj.each do |item|
        expect(item).to have_key('title')
        expect(item).to have_key('link')
        expect(item).to have_key('source')
        expect(item).to have_key('published_at')
      end
    end
  end
end