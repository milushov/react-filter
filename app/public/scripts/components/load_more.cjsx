# @cjsx React.DOM

#$ = require('jquery')
React  = require('react')

LoadMore = React.createClass(

  render: ->
    <a
      className='btn btn-default btn-large'
      onClick={@props.handleClick}>load more</a>
)

module.exports = LoadMore
