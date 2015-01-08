# @cjsx React.DOM

React  = require('react/addons')
Tab = require('./tab.cjsx')
TabCustom = require('./tab_custom.cjsx')

TabMenu = React.createClass(

  render: ->
    tabNodes = @props.tabs.map (tab) ->
      <Tab
        active={~@props.activeTabIds.indexOf(tab.id)}
        item={tab}
        onSelect={@props.navigateToTab} />
    , @

    <ul className="nav nav-pills tab-menu">
      {tabNodes}
      <TabCustom
        active={@props.activeTabIds.length == @props.tabs.length}
        tabs={@props.tabs}
        onSelect={@props.navigateToTab} />
    </ul>
)

module.exports = TabMenu
