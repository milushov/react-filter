# @cjsx React.DOM

React  = require('react/addons')
Tab = require('./tab.cjsx')

TabMenu = React.createClass(

  render: ->
    tabNodes = @props.tabs.map (tab) ->
      <Tab
        active={~@props.activeTabIds.indexOf(tab.id)}
        item={tab}
        onSelect={@props.navigateToTab} />
    , @

    <ul className="nav nav-pills">
      {tabNodes}
    </ul>
)

module.exports = TabMenu
