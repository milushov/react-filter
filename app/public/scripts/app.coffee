# @cjsx React.DOM

React = require('react')
Feed = require('./components/feed.cjsx')

React.render(
  Feed(), document.getElementById('filter')
)
