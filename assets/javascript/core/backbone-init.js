var Backbone = require('backbone');
var Cocktail = require('cocktail');

/*
  Fix backbone globally to
  - include the root API url on requests
*/
(function(){
  Backbone.syncOriginal = Backbone.sync;
  Backbone.sync = function(method, model, options){
    options = _.extend(options, {
      url: '/api/' + (_.isFunction(model.url) ? model.url() : model.url)
    });
    Backbone.syncOriginal( method, model, options );
  };

  Cocktail.patch(Backbone);

}())