Volontariat.UserRankingsShowController = Volontariat.Controller.extend(Volontariat.RankingController, Volontariat.PaginationController,
  yourRanking: true, routeName: ''  
  yourRankingClass: 'your_ranking_button btn btn-default active', globalRankingClass: 'global_ranking_button btn-default btn'
  adjective: '', negativeAdjective: '', topic: '', scope: ''
  thingName: '', best: true, stars: 3
  isBestClass: 'btn btn-default active', isWorstClass: 'btn btn-default'
  is1Star: '', is2Star: '', is3Star: 'active', is4Star: '', is5Star: ''
  paginationResource: 'user_ranking_item', paginationRoute: 'profile.rankings'
  
  _setBest: (without_stars) ->
    return if @get('best') 
    @set('best', true); @set('isBestClass', 'btn btn-default active'); @set('isWorstClass', 'btn btn-default')
    @_setStars(3) if !without_stars and @get('stars') <= 2
    
  _setWorst: (without_stars) -> 
    return unless @get('best', 'btn active')
    @set('best', false); @set('isBestClass', 'btn btn-default'); @set('isWorstClass', 'btn btn-default active')
    @_setStars(0) if !without_stars and @get('stars') > 0
  
  _setStars: (stars) ->
    if @get('stars') == stars
      @set('stars', stars - 1)
      $.each [1,2,3,4,5], (index, value) => @set('is' + value + 'Star', if value < stars then 'active' else '')
    else
      @set('stars', stars)
      $.each [1,2,3,4,5], (index, value) => @set('is' + value + 'Star', if value <= stars then 'active' else '')
      
    if stars >= 3 and !@get('best')
      @_setBest(true)
    else if stars <= 2 and @get('best')
      @_setWorst(true)
  
  actions:
      
    setBest: -> @_setBest()    
    setWorst: -> @_setWorst()  
          
    set1Star: -> @_setStars(1)
    set2Star: -> @_setStars(2)
    set3Star: -> @_setStars(3)
    set4Star: -> @_setStars(4)
    set5Star: -> @_setStars(5)    
        
    addItem: ->
      if !@get('thingName').trim() || !@get('adjective').trim() || !@get('negativeAdjective').trim() || !@get('topic').trim() || !@get('scope').trim()
        alert 'Please set thing, adjective, negative adjective, topic and scope.'
        return

      user_ranking_item = @store.createRecord(
        'user_ranking_item',
        thingName: @get('thingName'), best: @get('best'), stars: @get('stars'),
        adjective: @get('adjective'), negativeAdjective: @get('negativeAdjective'), topic: @get('topic'), scope: @get('scope') 
      )
      user_ranking_item.save().then =>
        @send('reload')
        
    destroy: (id)  ->
      $.ajax("/api/v1/user_ranking_items/#{id}", type: 'DELETE').done((data) =>
        @send('reload')
      ).fail((data) ->
        alert 'Removing item failed!'
      ) 
         
    reload: ->
      @transitionToRoute 'no_data'
      @transitionToRoute 'profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('page')
      
    moveToPreviousPage: (id) ->
      if @get('previousPage') <= 0
        alert 'No previous page available.'
        return
        
      $.post '/api/v1/user_ranking_items/' + id + '/move_to_page', { _method: 'put', page: @get('previousPage') }, (data) =>
        @transitionToRoute('profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('previousPage'))
        @send('reload')
        return

       
    moveToNextPage: (id) ->
      if @get('nextPage') > @get('totalPages')
        alert 'No next page available.'
        return
        
      $.post '/api/v1/user_ranking_items/' + id + '/move_to_page', { _method: 'put', page: @get('nextPage') }, (data) =>
        @transitionToRoute('profile.rankings', @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), @get('nextPage'))
        @send('reload')
        return 
)
