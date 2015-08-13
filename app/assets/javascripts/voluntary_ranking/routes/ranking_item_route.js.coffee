Volontariat.RankingItemRoute = Ember.Route.extend
  model: (params) ->
    Ember.$.getJSON(
      "/api/v1/user_ranking_items?thing_name=#{params.thing_name}&adjective=#{params.adjective}&" +
      "scope=#{params.scope}&topic=#{params.topic}&page=1"
    ).then (json) =>
      @controllerFor('ranking_item').set 'userRankingItems', json.user_ranking_items
    
    Ember.$.getJSON("/api/v1/things/#{params.thing_name}/is_one_of_the/#{params.adjective}/#{params.topic}/#{params.scope}.json").then (json) =>
      @controllerFor('ranking_item').set 'rankingItemThingName', json.ranking_item.thing_name
      @controllerFor('ranking_item').set 'position', json.ranking_item.position
      @controllerFor('ranking_item').set('adjective', json.ranking_item.ranking_adjective)
      @controllerFor('ranking_item').set('negativeAdjective', json.ranking_item.ranking_negative_adjective)
      @controllerFor('ranking_item').set('topic', json.ranking_item.ranking_topic)
      @controllerFor('ranking_item').set('scope', json.ranking_item.ranking_scope)
      json.ranking_item