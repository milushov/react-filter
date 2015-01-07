# @cjsx React.DOM

$ = require('jquery')
React = require('react')
Filter = require('./filter.cjsx')
ItemList = require('./item_list.cjsx')
LoadMore = require('./load_more.cjsx')


Feed = React.createClass(
  getInitialState: ->
    return(
      items: []

      categories: [
        {id: 1, name: 'laptops'}
        {id: 2, name: 'cameras'}
        {id: 3, name: 'cell phones'}
      ]

      filterParams: {
        categories: [1]
        price: {min: 0, max: 10000}
        merchants: [1, 2]
        sex: 1
        limit: 12
        offset: 0
      }
    )


  updateParams: (newParam) ->
    filterParams = @state.filterParams

    if newParam.name is 'categories'
      if ~(ind = filterParams.categories.indexOf(newParam.val))
        filterParams.categories.splice(ind, 1)
      else
        filterParams.categories.push(newParam.val)
        filterParams.categories = filterParams.categories.sort()
    else if newParam.name is 'price'
      filterParams.price = newParam.val

    filterParams.offset = 0
    filterParams.limit = 12

    @setState(filterParams: filterParams)
    @loadData()


  loadData: ->
    $.get('/api/products', @state.filterParams).then ((data) ->
      @setState(items: data)
    ).bind(@)


  loadMoar: ->
    filterParams = @state.filterParams
    filterParams.limit = filterParams.limit + 12
    console.info(filterParams)
    @setState(filterParams: filterParams)
    @loadData()


  componentDidMount: ->
    @loadData()


  render: ->
    <div className='feed'>
      <Filter
        categories={@state.categories}
        updateParams={@updateParams}
        filterParams={@state.filterParams} />

      <ItemList items={@state.items}/>
      <LoadMore handleClick={@loadMoar}/>
    </div>
)


module.exports = Feed