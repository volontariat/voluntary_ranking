Volontariat.RankingsIndexController = Volontariat.ArrayController.extend(Volontariat.PaginationController,
  paginationResource: 'ranking', paginationRoute: 'rankings.index', thingId: ''
  
  anyItems: (-> @get('content.length') > 0).property('content')
)