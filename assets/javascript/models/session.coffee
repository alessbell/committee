module.exports = Backbone.BaseModel.extend
  model_name: 'Session'
  initialize: () ->
    self = @
    self.set('committees', [])

  relations: [
    { type: Backbone.Many, key: 'committees', relatedModel: () -> require 'models/committee' }
    # { type: Backbone.Many, key: 'meetings', relatedModel: () -> require 'models/meeting' }
  ]