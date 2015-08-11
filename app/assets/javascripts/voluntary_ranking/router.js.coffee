Volontariat.Router.reopen location: 'hash'

Volontariat.Router.map ->
  @_super
  
  @resource 'profile', ->
    @route 'rankings', path: 'rankings/:adjective/and/:negative_adjective/:topic/:scope/page/:page' 
  
  @resource 'users', ->
    @resource 'user', path: ':user_id', ->
      @route 'movies'
 
  @resource 'rankings', ->
    @route 'show', path: ':adjective/and/:negative_adjective/:topic/:scope/page/:page'

  @resource 'thing', path: '/things/:thing_id', ->
    @resource 'rankings', ->
      @route 'index', path: 'page/:page'
      @route 'new'
    @resource 'arguments', ->
      @route 'index', path: 'page/:page'
      @route 'new' 
  
  @resource 'compare_things', path: '/things/:left_thing_name/vs/:right_thing_name', ->
    @route 'arguments', path: ':side/arguments/page/:page'
        
  # This route will be used to reload the current route by going to this route and then back to the current route
  @route 'no_data'