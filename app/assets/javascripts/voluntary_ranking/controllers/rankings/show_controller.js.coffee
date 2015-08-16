Volontariat.RankingsShowController = Volontariat.Controller.extend(Volontariat.RankingController, Volontariat.PaginationController,
  yourRanking: false, routeName: ''  
  yourRankingClass: 'your_ranking_button btn btn-default', globalRankingClass: 'global_ranking_button btn btn-default active'
  adjective: '', negativeAdjective: '', topic: '', scope: ''
  paginationResource: 'ranking_item', paginationRoute: 'rankings.show'
)