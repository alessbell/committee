Meeting = require 'models/meeting'
Committee = require 'models/committee'

CommitteeGraphSearchView = require 'views/committee-graph'

app = {}
views = {}

CommitteeApp = () ->
  @init = () ->
    views.committee_graph = new CommitteeGraphSearchView()

  true


$(document).ready () ->
  app = new CommitteeApp()
  app.init()

  true
