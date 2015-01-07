# @cjsx React.DOM

React  = require('react/addons')

PriceRange = React.createClass(

  componentDidMount: ->
    range = $(@refs.range.getDOMNode())
    info = $(@refs.curPrice.getDOMNode())

    range.on 'mousedown input', ((e) ->
      info.html("$#{e.target.value}")
    ).bind(@)

    range.on 'change', ((e) ->
      @props.handleRange(e.target.value)
    ).bind(@)

  # TODO remove listeners after unmount


  render: ->
    <nav>
      <input type="range"
        ref="range"
        min={@props.min}
        max={@props.max} />

      <span ref="curPrice"></span>
    </nav>
)

module.exports = PriceRange
