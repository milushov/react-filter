# @cjsx React.DOM

React = require('react')
Feed = require('./components/feed.cjsx')

window.feed = React.render(
  Feed(), document.getElementById('filter')
)
