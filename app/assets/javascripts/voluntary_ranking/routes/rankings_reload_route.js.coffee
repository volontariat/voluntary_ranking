VoluntaryOnEmberjs.RankingsReloadRoute = Ember.Route.extend
  redirect: ->
    @controllerFor('rankings.show').set('reloaded', true) 
  #  console.log 'rankings.reload: ' + @controllerFor('rankings.show').get('routeName')
    #@transitionTo(@controllerFor('rankings.show').get('routeName'))
    #@transitionTo('things.index')  
    #VoluntaryOnEmberjs.get('Router.router.currentHandlerInfos')
    
  if @controllerFor('navigation').get('listContext') == 'Global'
    @controllerFor('rankings.show').set('yourList', false)
  else
    @controllerFor('rankings.show').set('yourList', true)