require 'spec_helper'

RSpec.describe GoogleNews do
  it 'has a version number' do
    expect(GoogleNews::VERSION).not_to be nil
  end
end

RSpec.describe GoogleNews,'#headlines' do
  context 'Get headlines' do
    it 'fetches top headlines with default language' do
      gn = GoogleNews.new
      headlines = gn.headlines(n: 5)
      expect(headlines.length).to eq(5)
      headlines.each do |item|
        expect(item).to have_key(:title)
        expect(item).to have_key(:link)
        expect(item).to have_key(:source)
        expect(item).to have_key(:published_at)
      end
    end
  end

end
