require 'less/main.less'

# require 'images/favicon.ico'

###
this is a dummy file to make webpack compile our less files into css

until we get hot module replacement set up, we are using grunt's livereload

If we put `require 'main.less'` in core-bundle, then the core-bundle gets
updated when we make change in LESS so we lose our no-refresh CSS reloading

So instead we make this dummy file to force the css compilation and tell
grunt watch to ignore the file this is compiled to
###