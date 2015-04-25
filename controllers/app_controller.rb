
get '/' do
    redirect to('/example')
end

get '/example' do
    erb :example
end
