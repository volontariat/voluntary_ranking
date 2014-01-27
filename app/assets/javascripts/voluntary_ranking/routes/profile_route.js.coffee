VoluntaryOnEmberjs.ProfileRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'profile.index', controller: 'profile.index'   