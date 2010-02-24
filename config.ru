
require 'toto'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

toto = Toto::Server.new do
  set :title, "Nick's Blog"
  set :author, 'Nick Gerakines'
  set :disqus, 'socklabs-blog'
  set :url, 'http://blog.socklabs.com'
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

run toto
