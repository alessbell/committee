renderTemplate = (template) ->
  return (req, res, next) ->
    res.render(template)

module.exports = (app) ->
  app.get '/', renderTemplate('committee')