Volontariat.HasCurrentUser = Em.Mixin.create
  currentUser: (->
    Volontariat.User.current()
  ).property().volatile()