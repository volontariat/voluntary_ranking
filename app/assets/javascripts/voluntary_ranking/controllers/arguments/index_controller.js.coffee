Volontariat.ArgumentsIndexController = Ember.ArrayController.extend(Volontariat.HasCurrentUser, Volontariat.PaginationController,
  paginationResource: 'argument', paginationRoute: 'arguments.index', thingName: ''
  
  anyItems: (-> @get('content.length') > 0).property('content')
)