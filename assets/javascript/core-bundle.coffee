# Expose some big common libraries as globals
# so we dont have to require them in all of our files

window.$ = require 'jquery'
window._ = require 'lodash'
window.d3 = require 'd3/d3.js'
window.Rickshaw = require 'rickshaw'

# set up backbone with extensions
window.Backbone = require 'backbone'
Backbone.$ = window.$
require 'backbone.radio'
require 'core/backbone-init'
require 'core/backbone-base-model'

window.BB =
  # Api: require 'core/breather-api'
  radio: Backbone.Radio.channel('committee')
  models: {}
  UI: require 'core/core-ui'

window.App =
  init: () ->
    @views = {}

$(document).ready () ->
  BB.UI.init()
  App.init()
