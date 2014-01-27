# TODO: why .reopen and not .extend?
VoluntaryOnEmberjs.NavigationController = VoluntaryOnEmberjs.Controller.reopen
  listContext: 'Global'
  
  listContextDidChange: ((sender, key, value, rev) ->
    @transitionToRoute('rankings.reload')
  ).observes('listContext')

VoluntaryOnEmberjs.NavigationController.listContexts = ['Global', 'Your']