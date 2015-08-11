Volontariat.CompareThingsArgumentsController = Ember.ObjectController.extend(Volontariat.HasCurrentUser, Volontariat.PaginationController,
  paginationResource: 'argument', paginationRoute: 'compare_things.arguments', side: 'both', leftThingName: '', rightThingName: ''
  
  anyItems: (-> @get('content.length') > 0).property('content')
)