# @cjsx React.DOM

$ = require('jquery')
require('jquery-ui/slider')

React  = require('react/addons')

PriceRange = React.createClass(

  updateCurPrice: (values) ->
    info = $(@refs.curPrice.getDOMNode())
    info.html("$#{values[0]} - $#{values[1]}")


  componentDidMount: ->
    range = $(@refs.range.getDOMNode())
    info = $(@refs.curPrice.getDOMNode())

    initValues = [@props.min+1000, @props.max*0.8]

    range.slider(
      range: yes
      min: @props.min
      max: @props.max
      values: initValues
      slide: ((e, ui) ->
        @updateCurPrice(ui.values)
      ).bind(@)
      stop: ((e, ui) ->
        @props.handleRange.apply(@, ui.values)
      ).bind(@)
    )

    @updateCurPrice(initValues)


  # TODO remove listeners after unmount


  render: ->
    <div className='price-range'>
      <div ref="range"></div>
      <span className='price-range-cur-price' ref="curPrice"></span>
    </div>
)

module.exports = PriceRange
