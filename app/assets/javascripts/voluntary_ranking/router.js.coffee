VoluntaryOnEmberjs.Router.reopen location: 'hash'

VoluntaryOnEmberjs.Router.map ->
  @_super
  
  @route 'profile'
  
  @route 'product_ranking',
    path: '/products/ranking/'
      
  @resource 'users', ->
    @resource 'user', path: ':user_id', ->
      @route 'movies'
 
  #@resource 'user.movies', path: '/users/:user_id/movies' 
  
  @resource 'things', ->
    @resource 'things', path: ':thing_id'
    
  @resource 'movies', ->
    @resource 'movie', path: ':movie_id'    
      
  #@resource 'rankings', ->
  #  @route 'show', path: ':adjective/:topic/:scope'   
      
  @route 'rankings.show', path: ':adjective/and/:negative_adjective/:topic/:scope'    
  @route 'ranking'
  #@route 'user.rankings.show', path: 'users/:user_id/:adjective/:topic/:scope'    
      
VoluntaryOnEmberjs.ProductRankingRoute = Ember.Route.extend
  model: ->