
coffeescript_options = {
    input: 'public/javascripts/coffee',
    output: 'public/javascripts',
    patterns: [%r{^public/javascripts/coffee/(.+\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
    coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end

sass_options = {
    input: 'public/stylesheets/sass',
    output: 'public/stylesheets',
    patterns: [%r{^public/stylesheets/coffee/(.+\.(?:scss|scss\.md))$}]
}

guard 'sass', sass_options do
    sass_options[:patterns].each { |pattern| watch(pattern) }
end
