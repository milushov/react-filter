# @cjsx React.DOM

React  = require('react')


Tab = React.createClass(
  propTypes:
    onSelect: React.PropTypes.func.isRequired


  handleClick: (event) ->
    event.preventDefault()
    @props.onSelect @props.item.id


  render: ->
    className = React.addons.classSet(active: @props.active)

    <li className={className}>
      <a href={"#" + @props.item.id} onClick={@handleClick}>
        {@props.item.name}
      </a>
    </li>
)


module.exports = Tab
