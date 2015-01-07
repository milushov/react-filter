# @cjsx React.DOM

React  = require('react')
Item = require('./item.cjsx')

ItemList = React.createClass(


  makeRows: (items) ->
    rows = []
    _items = $.extend(true, [], items)

    while(_items.length)
      row = _items.splice(0,4).map (el) ->
        <Item item={el}/>
      rows.push row

    rows


  render: ->
    items = @props.items.map (el) ->

    <div className='item-list'>
      {@makeRows(@props.items)}
    </div>
)

module.exports = ItemList
