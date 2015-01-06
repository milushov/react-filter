# @cjsx React.DOM

React = require('react')
Filter = require('./filter.cjsx')
ItemList = require('./item_list.cjsx')


Feed = React.createClass(
  getInitialState: ->
    items: []
    categories: [
      {id: 1, name: 'laptops'}
      {id: 2, name: 'cameras'}
    ]


  loadData: ->
    $.get('/api/products').then ((data) ->
      @setState(items: data)
    ).bind(@)


  componentDidMount: ->
    @loadData()


  render: ->
    <div className='feed'>
      <Filter categories={@state.categories}/>
      <ItemList items={@state.items}/>
    </div>
)


module.exports = Feed