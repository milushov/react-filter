exports.routes = (app, obj) ->

  app.get '/filter', obj.show

  app.get '/api/products', obj.api.products

  app
