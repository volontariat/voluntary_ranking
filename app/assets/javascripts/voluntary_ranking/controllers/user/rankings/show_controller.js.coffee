VoluntaryOnEmberjs.UserRankingsShowController = VoluntaryOnEmberjs.ArrayController.extend(VoluntaryOnEmberjs.RankingController,
  listContext: 'Your', yourRanking: true, routeName: ''  
  yourRankingClass: 'btn active', globalRankingClass: 'btn'
  thingType: '', adjective: '', negativeAdjective: '', topic: '', scope: ''
  thingName: '', best: true, stars: 3
  isBestClass: 'btn active', isWorstClass: 'btn'
  is1Star: '', is2Star: '', is3Star: 'active', is4Star: '', is5Star: ''
  
  setBest: (without_stars) ->
    return if @get('best') 
    @set('best', true); @set('isBestClass', 'btn active'); @set('isWorstClass', 'btn')
    @setStars(3) if !without_stars and @get('stars') <= 2
    
  setWorst: (without_stars) -> 
    return unless @get('best', 'btn active')
    @set('best', false); @set('isBestClass', 'btn'); @set('isWorstClass', 'btn active')
    @setStars(0) if !without_stars and @get('stars') > 0
    
  set1Star: -> @setStars(1)
  set2Star: -> @setStars(2)
  set3Star: -> @setStars(3)
  set4Star: -> @setStars(4)
  set5Star: -> @setStars(5)
  
  setStars: (stars) ->
    if @get('stars') == stars
      @set('stars', stars - 1)
      $.each [1,2,3,4,5], (index, value) => @set('is' + value + 'Star', if value < stars then 'active' else '')
    else
      @set('stars', stars)
      $.each [1,2,3,4,5], (index, value) => @set('is' + value + 'Star', if value <= stars then 'active' else '')
      
    if stars >= 3 and !@get('best')
      @setBest(true)
    else if stars <= 2 and @get('best')
      @setWorst(true)
      
  addItem: ->
    #breadcrumb = VoluntaryRanking.get('Router.router.currentHandlerInfos')
    #@set('routeName', breadcrumb[breadcrumb.length - 1].name)
    console.log 'addItem scope1: ' + @get('scope')
    console.log 'addItem scope2: ' + @controllerFor('rankings.show').get('scope')
    user = VoluntaryRanking.User.find VoluntaryRanking.currentUser.id
    user_ranking_item = user.get('user_ranking_items').createRecord(
      thingName: @get('thingName'), best: @get('best'), stars: @get('stars'), thingType: @get('thingType'),
      adjective: @get('adjective'), negativeAdjective: @get('negativeAdjective'), topic: @get('topic'), scope: @get('scope') 
    )
    @get('store').commit()
    @set('thingName', ''); @set('stars', 3); @set('best', true)
    @set('is1Star', 'active'); @set('is2Star', 'active'); @set('is3Star', 'active');
    @set('is4Star', ''); @set('is5Star', '');
    
    @transitionToRoute('rankings.reload')
)
