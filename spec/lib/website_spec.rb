require_relative '../../lib/google_news'

RSpec.describe GoogleNews,'#website' do
  context 'Get headlines by website' do
    it 'fetches top headlines within a website and default language' do
      headlines = GoogleNews.website("https://www.starlink.com/", n: 5)
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