#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/base'
require 'mustache/sinatra'

class Few < Sinatra::Base
  register Mustache::Sinatra
  
  Dir["feeds/*"].each {|feed| require feed }
  
  set :mustache, {
    :views     => "views/",
    :templates => "templates/"
  }
  
  get '/feed/:feed_name.rss' do
    response.headers['Content-Type']  = "application/rss+xml"
    response.headers['Cache-Control'] = "public, max-age=900"

    mustache :feed, :layout => false
  end
end






# require 'rubygems'
# require 'open-uri'
# require 'nokogiri'
# require 'rss/maker'
# 
# def scrape_one(dd_id)
#   url = "http://www.viceland.com/int/dd.php?id=#{dd_id}"
#   body = open(url).read
# 
#   do_or_dont = body.match(/<h1>(.*?)<\/h1>/)[1]
#   img_url = "http://scs.viceland.com/img/dos_donts/#{dd_id}/main.jpg"
#   caption = body.scan(%r|<td\s+valign='top'\s+align='left'>([^>]+)<|mi).flatten.first.strip
# 
#   {:url => url, :do_or_dont => do_or_dont, :img_url => img_url, :caption => caption}
# end
# 
# current_id = 2402
# 
# item_attributes = []
# 
# 10.times do
#   item_attributes << scrape_one(current_id)
#   current_id -= 1
# end
# 
# content = RSS::Maker.make("2.0") do |m|
#   m.channel.title = "VICE Dos &amp; Don'ts"
#   m.channel.link  = "http://www.viceland.com/int/dos.php"
#   m.channel.description = "VIC Dos &amp; Don'ts"
#  
#   item_attributes.each do |a|
#     i = m.items.new_item
#     i.title = a[:do_or_dont]
#     i.link = a[:url]
#     i.date = Time.now
#     #puts "<center><img src='#{a[:img_url]}'><br /><p>#{a[:caption]}</p></center>"
#     i.description = "<center><img src='#{a[:img_url]}'><br /><p>#{a[:caption]}</p></center>".gsub('<','&lt;').gsub('>','&gt;')
#     #i.description = a[:caption]
#   end 
# end
# 
# puts content
