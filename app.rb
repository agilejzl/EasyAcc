
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

class App < Sinatra::Base
    register Sinatra::Reloader

    # set :views, File.dirname(__FILE__) + '/views'
    # set :public_folder, File.dirname(__FILE__) + '/public'

    Dir[ File.expand_path('../controllers/*.rb', __FILE__) ].each{|file| require file }
    Dir[ File.expand_path('../controllers/*.rb', __FILE__) ].each{|file| also_reload file }
end
