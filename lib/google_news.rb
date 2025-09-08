#
# Google News RSS Feed Parser
#

require 'open-uri'
require 'rss'
require 'uri'

module GoogleNews
  HEADLINES_RSS = 'https://news.google.com/news/rss'.freeze
  TOPICS_RSS    = 'https://news.google.com/news/rss/headlines/section/topic/'.freeze
  GEO_RSS       = 'https://news.google.com/news/rss/headlines/section/geo/'.freeze
  SEARCH_RSS    = 'https://news.google.com/rss/search?q='.freeze

  TOPICS = %w[WORLD NATION BUSINESS TECHNOLOGY ENTERTAINMENT SPORTS SCIENCE HEALTH].freeze

  class InvalidTopicError < StandardError; end

  #
  # Get top headlines from Google News
  #
  # @param [String] country
  # @param [String] language
  # @param [Integer] n
  # @return [Array<Hash>]
  def self.headlines(country: 'us', language: 'en', n: 10)
    url = HEADLINES_RSS + '?' + fill_country_lang_params(country, language)
    limited_items(url, n)
  end

  #
  # Get top headlines for a specific topic from Google News
  #
  # @param [String, Symbol] topic_name One of GoogleNews::TOPICS
  # @param [String] country
  # @param [String] language
  # @param [Integer] n
  # @return [Array<Hash>]
  #
  # @raise [InvalidTopicError] if topic_name is not valid
  def self.topic(topic_name, country: 'us', language: 'en', n: 10)
    topic_name = topic_name.to_s.upcase
    raise InvalidTopicError, 'Invalid topic name. See GoogleNews::TOPICS.' unless TOPICS.include?(topic_name)
    url = TOPICS_RSS + topic_name + '?' + fill_country_lang_params(country, language)
    limited_items(url, n)
  end

  #
  # Get top headlines for a specific geographic location from Google News
  #
  # @param [String] position e.g. "48.8566,2.3522" for Paris
  # @param [String] country
  # @param [String] language
  # @param [Integer] n
  # @return [Array<Hash>]
  #
  # Note: Google may not support all locations.
  # @see https://support.google.com/news/answer/6343863
  def self.geo(position, country: 'us', language: 'en', n: 10)
    encoded = URI.encode_www_form_component(position.to_s)
    url = GEO_RSS + encoded + '?' + fill_country_lang_params(country, language)
    limited_items(url, n)
  end

  #
  # Search Google News for a query
  #
  # @param [String] query
  # @param [String] country
  # @param [String] language
  # @param [Integer] n
  # @return [Array<Hash>]
  #
  # Note: This is not the same as a web search. Only news articles are returned.
  #       For a web search, consider using the Google Custom Search API.
  #
  # @see https://developers.google.com/custom-search/v1/overview
  #
  # @see https://support.google.com/news/answer/6343863
  def self.search(query, country: 'us', language: 'en', n: 10)
    encoded = URI.encode_www_form_component(query.to_s)
    url = SEARCH_RSS + encoded + '&' + fill_country_lang_params(country, language)
    limited_items(url, n)
  end

  #
  # Search Google News for articles from a specific website
  #
  # @param [String] query e.g. "example.com"
  # @param [String] country
  # @param [String] language
  # @param [Integer] n
  # @return [Array<Hash>]
  #
  # Note: This is not the same as a web search. Only news articles are returned.
  #       For a web search, consider using the Google Custom Search API.
  #
  # @see https://developers.google.com/custom-search/v1/overview
  #
  # @see https://support.google.com/news/answer/6343863
  #
  # Note: The parameter logic mimics the (possibly flawed) JavaScript version.
  #       It may not yield expected results for all websites.
  #
  # @example
  #
  #   GoogleNews.website("example.com", country: "us", language: "en", n: 5)
  #
  #   Returns up to 5 news articles from "example.com" in English for the US region.
  #
  def self.website(query, country: 'us', language: 'en', n: 10)
    # Repliziert die (möglicherweise fehlerhafte) Param-Logik aus JS: "site%3A..." + fillWebsiteParams
    encoded = 'site%3A' + URI.encode_www_form_component(query.to_s)
    url = SEARCH_RSS + encoded + '&' + fill_website_params(country, language)
    limited_items(url, n)
  end

  private

  #
  # Fill country and language parameters for Google News RSS URLs
  #
  # @param [String] country
  # @param [String] language
  # @return [String] URL parameters
  #
  # Note: This method intentionally matches the JavaScript version,
  #       even though Google typically expects 'hl' to denote language.
  #
  # @example
  #
  #   fill_country_lang_params("us", "en")
  #   # => "hl=US&gl=en&ceid=US%3Aen"
  #
  def self.fill_country_lang_params(country, language)
    c = country.to_s.upcase
    l = language.to_s.downcase
    # Bewusst identisch zur JS-Version (auch wenn Google typischerweise hl=Sprache erwartet)
    "hl=#{c}&gl=#{l}&ceid=#{c}%3A#{l}"
  end

  #
  # Fill parameters for website-specific Google News searches
  #
  # @param [String] country
  # @param [String] language
  # @return [String] URL parameters
  #
  # Note: This method replicates the unusual JavaScript parameter string.
  #
  # @example
  #
  #   fill_website_params("us", "en")
  #   # => "3ahl=en-US-&gl=en&ceid=US%3Aen-419"
  #
  # This replicates the unusual JS string (3ahl= ... -419)
  #
  def self.fill_website_params(country, language)
    c = country.to_s.upcase
    l = language.to_s.downcase
    # Repliziert exakt die ungewöhnliche JS-Zeichenkette (3ahl= ... -419)
    "3ahl=#{l}-#{c}-&gl=#{l}&ceid=#{c}%3A#{l}-419"
  end

  #
  # Fetch and limit items from a Google News RSS feed URL
  #
  # @param [String] url
  # @param [Integer] n
  # @return [Array<Hash>] limited to n items, returns an empty array if n <= 0 or on error occurs
  #
  # Note: Handles network errors gracefully by returning an empty array.
  #
  def self.limited_items(url, n)
    n = n.to_i
    return [] if n <= 0
    items = fetch_rss(url)
    items.first([n, items.size].min)
  rescue OpenURI::HTTPError, SocketError, IOError => e
    warn "[GoogleNews] Fehler beim Abruf #{url}: #{e.class}: #{e.message}"
    []
  end

  #
  # Fetch and parse a Google News RSS feed URL
  #
  # @param [String] url
  # @return [Array<Hash>] parsed items, returns an empty array if no items are found
  #
  # Note: Each item is represented as a hash with keys :title, :link, :pub_date, :description, and :raw_item.
  #
  def self.fetch_rss(url)
    content = URI.open(url, 'User-Agent' => default_user_agent, read_timeout: 10).read
    feed = RSS::Parser.parse(content, false)
    (feed&.items || []).map { |it| item_to_hash(it) }
  end

  #
  # Convert an RSS item to a hash
  #
  # @param [RSS::Rss::Channel::Item] item
  # @return [Hash] with keys :title, :link, :pub_date, :description, and :raw_item
  #
  def self.item_to_hash(item)
    {
      title: item.title,
      link: extract_link(item),
      pub_date: (item.respond_to?(:pubDate) ? item.pubDate : nil),
      description: (item.respond_to?(:description) ? item.description : nil),
      raw_item: item
    }
  end
  #
  # Extract the link from an RSS item
  #
  # @param [RSS::Rss::Channel::Item] item
  # @return [String, nil] the link if available, otherwise nil
  #
  # Note: This method checks if the item responds to :link before accessing it.
  #
  def self.extract_link(item)
    return item.link if item.respond_to?(:link)
    nil
  end

  #
  # Default User-Agent string for HTTP requests
  #
  # @return [String] User-Agent string
  #
  def self.default_user_agent
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
  end
end
