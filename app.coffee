fs            = require 'fs'
http          = require 'http'
https         = require 'https'
path          = require 'path'
url           = require 'url'

_             = require 'lodash'
querystring   = require 'querystring'
express       = require 'express'
compression   = require 'compression'
bodyParser    = require 'body-parser'
nconf         = require 'nconf'

view_helpers  = require './src/view-helpers'

app = express()

app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.locals.basedir = __dirname # enables absolute urls for includes in jade templates
app.set 'view options', { pretty: false }

app.use compression()

'css js'.split(' ').forEach (p) ->
  app.use('/'+p, express.static(__dirname + '/public/'+p))

(require './src/api-proxy')(app)

app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: true })

view_helpers.injectStaticHelpers(app)
app.use view_helpers.removeTrailingSlash

# routes
(require './src/controllers/committee')(app)

# if nconf.get('BREATHER_ENV') == 'local'
srv = http.createServer app
srv.listen 4000, ->
  # console.log nconf.get('PORT')
  console.log "Express server listening on port 4000"

module.exports = app

