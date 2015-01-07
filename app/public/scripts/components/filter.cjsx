# @cjsx React.DOM

React  = require('react')
TabMenu = require('./tab_menu.cjsx')
PriceRange = require('./price_range.cjsx')

Filter = React.createClass(

  navigateToTab: (id) ->
    @props.updateParams(name: 'categories', val: id)

  handleRange: (min, max) ->
    @props.updateParams(name: 'price', val: {min: min, max: max})

  render: ->
    <nav>
      <TabMenu
        navigateToTab={@navigateToTab}
        tabs={@props.categories}
        activeTabIds={@props.filterParams.categories} />
      <PriceRange
        min={@props.filterParams.price.min}
        max={@props.filterParams.price.max}
        handleRange={@handleRange}/>
    </nav>
)

module.exports = Filter
