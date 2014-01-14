VoluntaryOnEmberjs.Router.reopen location: 'hash'

VoluntaryOnEmberjs.Router.map ->
  @_super
  
  @route 'about'
  
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
      
  @resource 'rankings', ->
    
    @route 'reload', path: '/' 
    @route 'show', path: ':topic'   
      
VoluntaryOnEmberjs.ProductRankingRoute = Ember.Route.extend
  model: ->