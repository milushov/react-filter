# @cjsx React.DOM

React  = require('react')

Filter = React.createClass(

  render: ->
    items = @props.categories.map (el) ->
      <li dataId={el.id} key={el.id}>{el.name}</li>

    <div className='filter'>
      <ul>{items}</ul>
    </div>
)

module.exports = Filter
