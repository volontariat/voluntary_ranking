Volontariat.Singleton = Em.Mixin.create(
  current: ->
    @_current = @createCurrent()  unless @_current
    @_current

  createCurrent: ->
    @create {}

  currentProp: (property, value) ->
    instance = @current()
    return  unless instance
    if typeof (value) isnt "undefined"
      instance.set property, value
      value
    else
      instance.get property
)