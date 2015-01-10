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

    initValues = [@props.min, @props.max]

    range.slider(
      range: yes
      min: 0
      max: 1e4
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


  componentWillReceiveProps: (nextProps) ->
    console.info('yo, i\'m range', @props.min, @props.max)
    range = $(@refs.range.getDOMNode())
    range.slider('values', 0, nextProps.min)
    range.slider('values', 1, nextProps.max)


  render: ->
    <div className='price-range'>
      <div ref="range"></div>
      <span className='price-range-cur-price' ref="curPrice"></span>
    </div>
)

module.exports = PriceRange
