# TODO: why .reopen and not .extend?
Volontariat.NavigationController = Volontariat.Controller.reopen
  listContext: 'Global'
  
  listContextDidChange: ((sender, key, value, rev) ->
    unless $('.topic').val() == undefined
      if @get('listContext') == 'Your'
        @transitionToRoute('profile.rankings', $('.adjective').val(), $('.negative_adjective').val(), $('.topic').val(), $('.scope').val(), 1)
      else
        @transitionToRoute('rankings.show', $('.adjective').val(), $('.negative_adjective').val(), $('.topic').val(), $('.scope').val(), 1)
  ).observes('listContext')

Volontariat.NavigationController.listContexts = ['Global', 'Your']