# google_news
[![Gem](https://img.shields.io/gem/v/google_news?color=default&style=plastic&logo=ruby&logoColor=red)](https://rubygems.org/gems/google_news)
![downloads](https://img.shields.io/gem/dt/google_news?color=blue&style=plastic)
[![License: MIT](https://img.shields.io/badge/License-MIT-gold.svg?style=plastic&logo=mit)](LICENSE)

> Unofficial Ruby gem to get Google News RSS feeds easily from Ruby or the command line.

Inspired by [google-news-js](https://github.com/DatanewsOrg/google-news-js).

> [!WARNING]  
> Early alpha release. Use with caution.
> 
> TODOs:
> - CLI
>   - Support at all
>   - Support for different output formats (json, text, ...)
> - More tests
> - More documentation

### Contents
* [Common information](#common-information)
* [Installation](#installation)
* [Usage](#usage)
* [Command line](#command-line-usage)
* [Documentation](#documentation)
* [Contributing](#contributing)



<a name="common-information"></a>    
## Common information

This is just a simple RSS feed parser for Google News RSS feeds.

Can also be used from the [command line](#command-line-usage)!

There is support for:
* Top stories
* News by topic
* News by location
* News by keyword
* News by source
* News by language


<a name="installation"></a>
## Installation
### Ruby
Add this line to your application's Gemfile:

```ruby
gem 'google_news'
```

And then execute:

    bundle install

### Command line
If you just want to use the command line then run

    gem install google_news





<a name="usage"></a>
## Usage

```ruby
require 'google_news'

results = GoogleNews.headlines n: 5 # get top 5 news in default language (country: us, language: en)
puts results
# => [
# {
#   :title =>    "Title of the news article", 
#   :link =>     "https://link.to/the/article", 
#   :pub_date => Time("Wed, 01 Jan 2024 00:00:00 GMT"), 
#   :descriptions => [
#     {
#       :title => "First article, like :title",
#       :link => "https://link.to/the/first/article",
#       :author => "Author Name",
#     },
#    {
#      :title => "Second article, same topic, similiar to first",
#      :link => "https://link.to/the/second/article",
#     :author => "Another Author Name",
#    },
#    ...
#  ],
# ]
```



<a name="command-line-usage"></a>
## Command line

`google_news` is also available on the command line after installation.

The results are printed in JSON format by default.



```bash
$ google_news --help
Usage: google_news [options]
    -n, --number NUMBER                Number of news articles to fetch (default: 10)
    -c, --country COUNTRY              Country code (default: 'us')
    -l, --language LANGUAGE            Language code (default: 'en')
    -t, --topic TOPIC                  News topic (e.g., 'world', 'business', 'technology', etc.)
    -s, --source SOURCE                News source (e.g., 'bbc-news', 'cnn', etc.)
    -k, --keyword KEYWORD              Keyword to search for in news articles
    -f, --format FORMAT                Output format: 'json' (default) or 'text'
    -h, --help                         Show this help message
```

### Examples

Fetch top 5 news articles in the default language (country: us, language: en):
```bash
$ google_news -n 5
```

<a name="documentation"></a>
## Documentation
Detailed (code) documentation is available at [https://www.rubydoc.info/gems/google_news](https://www.rubydoc.info/gems/google_news).



<a name="contributing"></a>
## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/magynhard/google_news. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

