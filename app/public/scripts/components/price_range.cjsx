# @cjsx React.DOM

$ = require('jquery')
require('jquery-ui/slider')

React  = require('react/addons')

PriceRange = React.createClass(

  componentDidMount: ->
    range = $(@refs.range.getDOMNode())
    info = $(@refs.curPrice.getDOMNode())

    range.slider(
      range: yes
      min: @props.min
      max: @props.max
      values: [@props.min*0.1, @props.max*0.8]
      slide: ((e, ui) ->
        info.html( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ])
      ).bind(@)
      stop: ((e, ui) ->
        @props.handleRange.apply(@, ui.values)
      ).bind(@)
    )

  # TODO remove listeners after unmount


  render: ->
    <div class='price-range'>
      <div ref="range"></div>
      <span ref="curPrice"></span>
    </div>
)

module.exports = PriceRange
