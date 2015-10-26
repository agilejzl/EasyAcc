
require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'

class App < Sinatra::Base
    register Sinatra::Reloader

    Dir[ File.expand_path('../controllers/*.rb', __FILE__) ].each { |file| require file }
    Dir[ File.expand_path('../controllers/*.rb', __FILE__) ].each { |file| also_reload file }
end
