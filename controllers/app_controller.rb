
get '/' do
    redirect to('/example')
end

get '/example' do
    erb :example
end

get '/ajax_search' do
    params_to_str = ""
    params_to_str += "search?q=#{params[:q]}" unless params[:q] == ""

    body_ios = open("http://www.reddit.com/#{params_to_str}")
    body_ios.lines.first
end
