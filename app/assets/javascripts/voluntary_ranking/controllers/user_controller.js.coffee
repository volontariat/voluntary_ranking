Volontariat.UserController = Ember.Controller.extend(Volontariat.HasCurrentUser, Volontariat.PaginationController,
  rankings: [], paginationResource: null, paginationRoute: 'user'
  
  anyRankings: (-> @get('rankings').length > 0).property('rankings')
)