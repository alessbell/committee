module.exports = Backbone.BaseModel.extend
  model_name: 'Committee'
  # urlRoot: '/committees'
  initialize: () ->
    self = @
    self.set('meetings', [])

  relations: [
    { type: Backbone.Many, key: 'meetings', relatedModel: () -> require 'models/committee' }
    # { type: Backbone.One, key: 'session', relatedModel: () -> require 'models/session' }
  ]