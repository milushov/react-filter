# @cjsx React.DOM

#$ = require('jquery')
React  = require('react')

LoadMore = React.createClass(

  render: ->
    <div className='row text-center'>
      <a
        className='btn btn-primary btn-large'
        onClick={@props.handleClick}>load more</a>
    </div>
)

module.exports = LoadMore
