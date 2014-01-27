VoluntaryOnEmberjs.HasCurrentUser = Em.Mixin.create
  currentUser: (->
    VoluntaryOnEmberjs.User.current()
  ).property().volatile()