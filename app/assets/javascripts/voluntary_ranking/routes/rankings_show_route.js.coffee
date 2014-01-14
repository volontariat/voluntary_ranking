VoluntaryOnEmberjs.RankingsShowRoute = Ember.Route.extend
  model: ->
    console.log 'rankings.show model'
    #routeToTopic = { 'movies.index': 'Movie', 'things.index': 'Thing' }
    #topic = routeToTopic[@controllerFor('rankings.show').get('routeName')]
    @controllerFor('rankings.show').set('reloaded', false) 
    default_attributes = { 'adjective': 'best', 'negativeAdjective': 'worst', 'scope': 'ever' }
    
    $.each default_attributes, (attribute, value) =>
      @controllerFor('rankings.show').set(attribute, value) if @controllerFor('rankings.show').get(attribute) == ''
    
    attributes = {}
    
    $.each ['thingType', 'adjective', 'negativeAdjective', 'topic', 'scope'], (index, attribute) =>
      attributes[attribute] = @controllerFor('rankings.show').get(attribute)
     
    if @controllerFor('navigation').get('listContext') == 'Global'
      VoluntaryOnEmberjs.RankingItem.find
        thingType: attributes['thingType'], adjective: attributes['adjective'], 
        negativeAdjective: attributes['negativeAdjective'], topic: attributes['topic'], 
        scope: attributes['scope']
    else
      VoluntaryOnEmberjs.UserRankingItem.find
        user_id: VoluntaryOnEmberjs.currentUser['id']
        thingType: attributes['thingType'], adjective: attributes['adjective'], 
        negativeAdjective: attributes['negativeAdjective'], topic: attributes['topic'], 
        scope: attributes['scope']
    
  setupController: (controller, model) ->
    @controllerFor('rankings.show').set('model', model)
    
  renderTemplate: ->
    @render 'rankings.show', controller: 'rankings.show'   
    
VoluntaryOnEmberjs.ThingsIndexRoute = VoluntaryOnEmberjs.RankingsShowRoute.extend() 
VoluntaryOnEmberjs.MoviesIndexRoute = VoluntaryOnEmberjs.RankingsShowRoute.extend()