VoluntaryOnEmberjs.Router.reopen
  map: ->
    alert 'ranking router 3'
    @_super
    
    
    
    @route 'product_ranking',
      path: '/products/ranking'
    
    @resource 'users', ->
      @resource 'user', path: ':user_id', ->
        @route 'movies'