# @cjsx React.DOM

$ = require('jquery')
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
    result = if @props.items.length
      @makeRows(@props.items)
    else
      <h3 className='text-center'>
        there are no products that match your search criteria :(
      </h3>

    <div className='item-list row'>
      {result}
    </div>
)

module.exports = ItemList
