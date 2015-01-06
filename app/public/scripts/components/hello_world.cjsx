# @cjsx React.DOM

React = require('react')

Hello = React.createClass(
  render: ->
    <div>yo, {this.props.name}!</div>
)

module.exports = Hello
