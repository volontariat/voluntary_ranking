Volontariat.RankingsIndexController = Volontariat.Controller.extend(Volontariat.PaginationController,
  paginationResource: 'ranking', paginationRoute: 'rankings.index', thingName: ''
  
  anyItems: (-> @get('content.length') > 0).property('content')
)