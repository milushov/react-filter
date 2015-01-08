# @cjsx React.DOM

React  = require('react')


Tab = React.createClass(
  propTypes:
    onSelect: React.PropTypes.func.isRequired


  handleClick: (event) ->
    event.preventDefault()
    @props.onSelect @props.tabs.map (el) -> el.id


  render: ->
    className = React.addons.classSet(active: @props.active, 'tab-custom': true)

    <li className={className}>
      <a href='#' onClick={@handleClick}>
        All
      </a>
    </li>
)


module.exports = Tab
