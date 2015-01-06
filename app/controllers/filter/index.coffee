exports.customController = yes

exports.show = (req, res) ->
  db = req.app.get('db')
  res.render 'show'


exports.api = {
  products: (req, res, next) ->
    db = req.app.get('db')
    db.Product.findAll(limit: 10).then (items) ->
      res.json items.map (el) ->
        id:    el.id
        name:  el.name
        image: el.image
        price: el.price

}
