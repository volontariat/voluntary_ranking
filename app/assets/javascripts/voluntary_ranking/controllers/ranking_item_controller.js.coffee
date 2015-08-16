Volontariat.RankingItemController = Ember.Controller.extend(Volontariat.HasCurrentUser, Volontariat.RankingController, Volontariat.PaginationController,
  position: null, yourRankingClass: 'your_ranking_button btn btn-default', globalRankingClass: 'global_ranking_button btn btn-default active',
  userRankingItems: []
  paginationResource: null, paginationRoute: 'ranking_item'
  
  anyUserRankingItems: (-> @get('userRankingItems').length > 0).property('userRankingItems')
)