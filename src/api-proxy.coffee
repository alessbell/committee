httpProxy = require 'http-proxy'
nconf = require 'nconf'
URI = require 'URIjs'

API_URL = 'http://api.openparliament.ca'
api_uri = URI(API_URL)

api_proxy = httpProxy.createProxyServer(
  target: API_URL
  xfwd: false
)

# capture proxy errors
# see: https://github.com/nodejitsu/node-http-proxy/issues/527
# see: https://github.com/nodejitsu/node-http-proxy/issues/813
# usually its the client aborted the request by reloading too fast
# this fixes the issue for now, but may be catching other errors?
api_proxy.on 'error', (err, req, res) ->
  console.log 'proxy error - '+err
  if !res.headersSent
    res.status(500).json
      error: {
        type: 'ProxyError'
        details: 'There was an error with API proxy'
      }

# add custom headers
# api_proxy.on 'proxyReq', (proxyReq, req, res, options) ->
#   proxyReq.setHeader('x-breather-client', 'backstage')

module.exports = (app) ->
  app.use('/api/', (req, res, next) ->
    # changes the host header -- required to work with heroku
    req.headers.host = api_uri.hostname();
    api_proxy.web(req, res)
  )