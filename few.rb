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