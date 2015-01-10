# @cjsx React.DOM

$ = require('jquery')
React = require('react')
Filter = require('./filter.cjsx')
ItemList = require('./item_list.cjsx')
LoadMore = require('./load_more.cjsx')

copy = (source) ->
  $.extend(true, {}, source)

Feed = React.createClass(
  getInitialState: ->

    return(
      items: []

      categories: [
        {id: 1, name: 'laptops'}
        {id: 2, name: 'cameras'}
        {id: 3, name: 'cell phones'}
      ]

      sexList: ['male', 'all', 'female']

      filterParams: copy(@defaultFilterParams)
    )

  # default params
  defaultFilterParams: {
    categories: [1]
    price: {min: 0, max: 10000}
    merchants: [1, 2]
    sex: 'all' # male | female | all
    limit: 12
    offset: 0
  }


  updateParams: (newParam) ->
    filterParams = @state.filterParams

    if newParam.name is 'categories'
      if typeof newParam.val is 'number'
        if ~(ind = filterParams.categories.indexOf(newParam.val))
          filterParams.categories.splice(ind, 1)
        else
          filterParams.categories.push(newParam.val)
          filterParams.categories = filterParams.categories.sort()
      else
        # in case we disable/enable all tabs,
        # ie passing array of ids
        if filterParams.categories.length is newParam.val.length
          filterParams.categories = []
        else
          filterParams.categories = newParam.val
    else if newParam.name is 'price'
      filterParams.price = newParam.val
    else if newParam.name is 'sex'
      filterParams.sex = newParam.val

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
    @setState(filterParams: filterParams)
    @loadData()


  componentDidMount: ->
    @loadData()


  resetFilterParams: ->
    @setState(filterParams: copy(@defaultFilterParams))
    @loadData()


  render: ->
    <div className='feed'>
      <Filter
        categories={@state.categories}
        sexList={@state.sexList}
        updateParams={@updateParams}
        filterParams={@state.filterParams}
        resetFilter={@resetFilterParams}/>

      <ItemList items={@state.items}/>
      <LoadMore handleClick={@loadMoar}/>
    </div>
)


module.exports = Feed