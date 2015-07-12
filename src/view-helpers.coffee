staticHelpers = {}

module.exports.injectStaticHelpers = (app) ->
  app.locals.moment = require 'moment-timezone'

  # placeholder for CDN assets stuff
  app.locals.hashUrl = (url) -> url

module.exports.removeTrailingSlash = (req, res, next) ->
  if req.path.substr(-1) == '/' && req.path.length > 1
    query = req.url.slice(req.path.length)
    res.redirect(301, req.path.slice(0, -1) + query)
  else
    next()