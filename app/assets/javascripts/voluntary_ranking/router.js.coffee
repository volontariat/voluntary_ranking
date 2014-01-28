VoluntaryOnEmberjs.Router.reopen location: 'hash'

VoluntaryOnEmberjs.Router.map ->
  @_super
  
  @resource 'profile', ->
    @route 'rankings', path: 'rankings/:adjective/and/:negative_adjective/:topic/:scope' 
  
  @resource 'users', ->
    @resource 'user', path: ':user_id', ->
      @route 'movies'
 
  @resource 'rankings', ->
    @route 'show', path: ':adjective/and/:negative_adjective/:topic/:scope'
        
  #@route 'user.rankings.show', path: 'users/:user_id/rankings/:adjective/and/:negative_adjective/:topic/:scope'    