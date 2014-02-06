VoluntaryOnEmberjs.UserRankingsShowController = VoluntaryOnEmberjs.ArrayController.extend(VoluntaryOnEmberjs.RankingController,
  listContext: 'Your', yourRanking: true, routeName: ''  
  yourRankingClass: 'btn active', globalRankingClass: 'btn'
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  thingName: '', best: true, stars: 3
  isBestClass: 'btn active', isWorstClass: 'btn'
  is1Star: '', is2Star: '', is3Star: 'active', is4Star: '', is5Star: ''
  
  _setBest: (without_stars) ->
    return if @get('best') 
    @set('best', true); @set('isBestClass', 'btn active'); @set('isWorstClass', 'btn')
    @_setStars(3) if !without_stars and @get('stars') <= 2
    
  _setWorst: (without_stars) -> 
    return unless @get('best', 'btn active')
    @set('best', false); @set('isBestClass', 'btn'); @set('isWorstClass', 'btn active')
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
      user_ranking_item.save()
      @set('thingName', ''); @_setStars(3)
      @send('reload')
      
    reload: ->
      @set('model', @store.find('user_ranking_item', user_id: VoluntaryOnEmberjs.User.current().id, adjective: @get('adjective'), negative_adjective: @get('negativeAdjective'), topic: @get('topic'), scope: @get('scope')))
)
