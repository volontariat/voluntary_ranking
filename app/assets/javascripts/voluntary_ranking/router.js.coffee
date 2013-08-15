VoluntaryOnEmberjs.Router.map ->
  @_super

  @route 'product_ranking',
    path: '/products/ranking/'
      
VoluntaryOnEmberjs.ProductRankingRoute = Ember.Route.extend
  model: ->
