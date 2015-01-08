exports.customController = yes

exports.show = (req, res) ->
  db = req.app.get('db')
  res.render 'show'


exports.api = {
  products: (req, res, next) ->
    db = req.app.get('db')
    params = req.query

    console.info('\n\n\n\n')
    console.info(params)
    console.info('\n\n\n\n')

    # I know about sql injections, but fuck dat, because it's just an api for testing purposes
    sexVal = if params.sex is 'male'
      true
    else if params.sex is 'female'
      false
    else
      null

    db.Product.findAll(
      where:
        merchantId: params.merchants,
        price:
          gte: params.price?.min
          lte: params.price?.max
        sex: sexVal

      limit: params.limit
      offset: params.offset

      include:
        model: db.Category
        where:
          id: params.categories

    ).then (items) ->
      console.info('\n\n\n\n')
      console.info(items[0])
      console.info('\n\n\n\n')

      res.json items.map (el) ->
        id:    el.id
        name:  el.name
        image: el.image
        price: el.price
        merchant_id: el.merchantId
        cat_id: el.Categories[0].id

}
