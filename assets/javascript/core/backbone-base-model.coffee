require 'backbone-associations'
require 'backbone-computedfields'

Backbone.BaseModel = Backbone.AssociatedModel.extend
  constructor: () ->
    Backbone.Model.apply(this, arguments)

  initialize: () ->
    this.computedFields = new Backbone.ComputedFields(this)