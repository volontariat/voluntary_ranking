Volontariat.Router.reopen location: 'hash'

Volontariat.Router.map ->
  @_super
  
  @resource 'profile', ->
    @route 'rankings', path: 'rankings/:adjective/and/:negative_adjective/:topic/:scope/page/:page' 
  
  @resource 'user', path: '/users/:name'
 
  @route 'user_ranking', path: '/users/:user_name/rankings/:adjective/and/:negative_adjective/:topic/:scope/page/:page'
 
  @resource 'rankings', ->
    @route 'show', path: ':adjective/and/:negative_adjective/:topic/:scope/page/:page'

  @resource 'thing', path: '/things/:name', ->
    @resource 'rankings', ->
      @route 'index', path: 'page/:page'
      @route 'new'
    @resource 'arguments', ->
      @route 'index', path: 'page/:page'
      @route 'new' 
  
  @resource 'compare_things', path: '/things/:left_thing_name/vs/:right_thing_name', ->
    @route 'arguments', path: ':side/arguments/page/:page'
  
  @resource 'ranking_item', path: '/things/:thing_name/is_one_of_the/:adjective/:topic/:scope'
        
  # This route will be used to reload the current route by going to this route and then back to the current route
  @route 'no_data'