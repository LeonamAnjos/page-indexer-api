# Page Indexer

### Introduction

Page Indexer parse the content of tags *h1, h2, h3*, and *links* of a HTML and keep it to further references. It is written in Ruby on Rails and it is [JsonAPI](http://jsonapi.org) compatible.

### Solution
The application has two main endpoints:
- ___POST /pages___ - receives a URL and save the parsed content.
- ___GET /pages___ - list all URL parsed.

### Installation
Download _Page Indexer_ project from [GitHub] (https://github.com/LeonamAnjos/page-indexer-api) or clone it with following command:

```sh
$ git clone https://github.com/LeonamAnjos/page-indexer-api.git
$ cd page-indexer-api
```
Install the _"gems"_ listed in the Gemfile, prepare de database and start the applicatoin.
```sh
$ bundle install
$ rake db:migrate
$ rails server
```

### Running
Run the script below to parse the HTML served by the URL:
```sh
$ curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X POST -d '{"data": {"type":"pages", "attributes":{"url":"http://example.com"}}}' http://localhost:3000/pages
```

Run the script below to list all parsed pages:
```sh
$ curl -i -H "Accept: application/vnd.api+json" -H 'Content-Type:application/vnd.api+json' -X GET -d '{"data": {"type":"pages", "attributes":{}}}' http://localhost:3000/pages
```