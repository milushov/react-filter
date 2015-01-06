# @cjsx React.DOM

React  = require('react')
helpers = require('../../../lib/view_helpers.coffee')()

Item = React.createClass(

  render: ->

    <div className="col-xs-3 col-sm-3 product item-list-item">
      <div className="row text-center">
        <img src={@props.item.image}/>
      </div>

      <div className="row">
        <span className="product-price label label-danger">
          {@props.item.price}
        </span>
      </div>

      <div className="row">
        <span>{helpers.truncate(@props.item.name, 30)}</span>
      </div>

    </div>
)

module.exports = Item
