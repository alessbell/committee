module.exports = Backbone.BaseModel.extend
  model_name: 'Meeting'
  # urlRoot: '/committees/meetings'
  initialize: () ->
    self = @

  # relations: [
  #   { type: Backbone.One, key: 'committee', relatedModel: () -> require 'models/committee' }
  #   { type: Backbone.One, key: 'session', relatedModel: () -> require 'models/session' }
  # ]