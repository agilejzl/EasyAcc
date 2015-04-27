
get '/' do
    redirect to('/example')
end

get '/example' do
    erb :example
end

get '/ajax_search' do
    params_to_str = ""
    params_count = params[:count].to_i
    @count = (params_count >= 0 ? params_count : 0)
    if params[:q] == ""
        params_to_str += "?count=#{@count}"
    else
        params_to_str += "search?q=#{params[:q]}&count=#{@count}"
    end

    body_ios = open("http://www.reddit.com/#{params_to_str}")
    body_ios.each_line.first
end
