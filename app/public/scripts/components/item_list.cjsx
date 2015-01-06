# @cjsx React.DOM

React  = require('react')
Item = require('./item.cjsx')

ItemList = React.createClass(


  makeRows: (items) ->
    _items = []
    while(items.length)
      row = items.splice(0,4).map (el) ->
        <Item item={el}/>
      _items.push row

    _items


  render: ->
    items = @props.items.map (el) ->

    <div className='item-list'>
      {@makeRows(@props.items)}
    </div>
)

module.exports = ItemList
