# @jsx React.DOM

React  = require('react')

SexRadio = React.createClass(
  componentDidMount: ->
    @setRadioNames()
    @setCheckedRadio()


  componentDidUpdate: ->
    @setRadioNames()


  setRadioNames: ->
    $radios = @getRadios()
    i = 0

    while i < $radios.length
      $radios[i].setAttribute 'name', @props.name
      i++

  getRadios: ->
    @getDOMNode().querySelectorAll('input[type="radio"]')

  setCheckedRadio: ->
    $radios = @getRadios()
    i = 0
    length = $radios.length

    while i < length
      $radio = $radios[i]
      $radio.checked = true  if $radio.value is @props.value
      i++

  getCheckedValue: ->
    $radios = @getRadios()
    i = 0
    length = $radios.length

    while i < length
      return $radios[i].value if $radios[i].checked
      i++
    null

  render: ->
    inputs = @props.values.map ((el) ->
      <span>
        <input
          type='radio'
          id={el}
          value={el}
          onChange={@props.onChange}/>
        <label htmlFor={el}>
          {el}
        </label>
      </span>
    ).bind(@)

    <div className='sex-radio-form'>
      {inputs}
    </div>
)

module.exports = SexRadio
