#!/usr/bin/env ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'

def scrape_one(dd_id)
  puts dd_id
  body = open("http://www.viceland.com/int/dd.php?id=#{dd_id}").read

  do_or_dont = body.match(/<h1>(.*?)<\/h1>/)[1]
  img_url = "http://scs.viceland.com/img/dos_donts/#{dd_id}/main.jpg"
  caption = body.scan(%r|<td\s+valign='top'\s+align='left'>([^>]+)<|mi).flatten.first.strip

  {:do_or_dont => do_or_dont, :img_url => img_url, :caption => caption}
end

current_id = 2402

10.times do
  attributes = scrape_one(current_id)
  puts attributes.inspect
  current_id -= 1
end

