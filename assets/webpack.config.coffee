path = require 'path'

webpack = require 'webpack'
ExtractTextPlugin = require 'extract-text-webpack-plugin'
CommonsChunkPlugin = webpack.optimize.CommonsChunkPlugin

module.exports =
  context: 'assets'
  entry:
    'home-page': './javascript/homepage.coffee'
    'core-bundle': './javascript/core-bundle.coffee' # explicit common bundle
    'core-style': './javascript/core-style.coffee'

    # pages

  output:
    path: 'public'
    filename: 'js/[name].js'
    sourceMapFilename: 'js/[name].map'

  resolve:
    root: [
      __dirname
      path.join(__dirname, 'src', 'main', 'assets')
    ]
    extensions: ['', '.js', '.json', '.coffee', '.jsx']
    modulesDirectories: ['assets/javascript', 'bower_components', 'node_modules']
    alias:
      scripts: __dirname + '/javascript'
      less: __dirname + '/less'

  module:
    loaders: [
      {include: /\.json$/, loaders: ["json-loader"]}

      { test: /\.coffee$/, loader: 'coffee' }
      # { test: /\.less$/, loader: 'style!css!less' }
      { test: /\.css$/, loader: ExtractTextPlugin.extract('style', 'css!autoprefixer') }
      { test: /\.less$/, loader: ExtractTextPlugin.extract('style', 'css!autoprefixer!less') }
    ]

  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
    ),

    new ExtractTextPlugin('css/core.css', { allChunks: true }),
    # new ExtractTextPlugin('css/[name].css'),

    # explicitly make core-bundle a "common" chunk bundle
    # so other bundles will not include things already loaded
    # new CommonsChunkPlugin({ name: 'core-bundle' })
  ]

  stats:
    colors: false
    modules: false
    reasons: true

  failOnError: false

  watch: true