require_relative '../../lib/google_news'

RSpec.describe GoogleNews,'#topic' do
  context 'Get headlines by topics' do
    it 'fetches top headlines with topic SPORTS and default language' do
      headlines = GoogleNews.topic('SPORTS', n: 5)
      expect(headlines.length).to eq(5)
      headlines.each do |item|
        expect(item).to have_key(:title)
        expect(item).to have_key(:link)
        expect(item).to have_key(:pub_date)
        expect(item).to have_key(:description)
        expect(item).to have_key(:raw_item)

        expect(item[:link]).to match(/^https?:\/\//)
      end
    end
  end
end