# @cjsx React.DOM

React  = require('react')
TabMenu = require('./tab_menu.cjsx')
PriceRange = require('./price_range.cjsx')
SexRadio = require('./sex_radio.cjsx')

Filter = React.createClass(

  navigateToTab: (id) ->
    @props.updateParams(name: 'categories', val: id)

  handleRange: (min, max) ->
    @props.updateParams(name: 'price', val: {min: min, max: max})

  handleRadio: (e) ->
    @props.updateParams(name: 'sex', val: e.target.value)

  render: ->
    <nav className='feed-filter'>
      <div className='row'>
        <div className='col-xs-12 col-sm-12'>
          <TabMenu
            navigateToTab={@navigateToTab}
            tabs={@props.categories}
            activeTabIds={@props.filterParams.categories} />
        </div>
      </div>

      <div className='row'>
        <div className='col-xs-4 col-sm-4'>
          <PriceRange
            min={@props.filterParams.price.min}
            max={@props.filterParams.price.max}
            handleRange={@handleRange}/>
        </div>

        <div className='col-xs-4 col-sm-4'>
          <SexRadio
            name='sex'
            value={@props.filterParams.sex}
            values={@props.sexList}
            ref='sexGroup'
            onChange={this.handleRadio} />
        </div>
      </div>
    </nav>
)

module.exports = Filter
