# TODO: why .reopen and not .extend?
VoluntaryRanking.NavigationController = Ember.Controller.reopen
  listContext: 'Global'
  
  listContextDidChange: ((sender, key, value, rev) ->
    @transitionToRoute('lists.reload')
  ).observes('listContext')

VoluntaryRanking.NavigationController.listContexts = ['Global', 'Your']