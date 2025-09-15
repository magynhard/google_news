require_relative '../../lib/google_news'

RSpec.describe GoogleNews,'#geo' do
  context 'Get headlines by geo' do
    it 'fetches top headlines with geo of Berlin and default language' do
      headlines = GoogleNews.geo("Berlin", n: 5)
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