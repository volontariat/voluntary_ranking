# TODO: why .reopen and not .extend?
VoluntaryOnEmberjs.NavigationController = Ember.Controller.reopen
  listContext: 'Global'
  needs: ['rankings.show']
  
  listContextDidChange: ((sender, key, value, rev) ->
    #@transitionToRoute('rankings.reload')
    console.log 'listContext: ' + @listContext
    
    #if @controllerFor('navigation').get('listContext') == 'Global'
    if @listContext == 'Global'
      @controllerFor('rankings.show').set('yourList', false)
      #@set('yourList', false)
    else
      @controllerFor('rankings.show').set('yourList', true)
      #@set('yourList', true)
      
    @transitionToRoute('rankings.reload') 
      
  ).observes('listContext')

VoluntaryOnEmberjs.NavigationController.listContexts = ['Global', 'Your']