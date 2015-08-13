Volontariat.UserRankingItem = DS.Model.extend
  user: DS.belongsTo('user')
  #ranking: DS.belongsTo('ranking')
  #thing: DS.belongsTo('thing', { polymorphic: true })
  #thing: DS.belongsTo('thing')
  #thing: DS.belongsTo('thing',
  #  polymorphic: true
  #)
  position: DS.attr('number')
  
  thingId: DS.attr('number')
  thingType: DS.attr('string')
  thingName: DS.attr('string')
  best: DS.attr('boolean')
  stars: DS.attr('number')
  is1StarClass: (-> @get('stars') >= 1).property('stars')
  is2StarClass: (-> @get('stars') >= 2).property('stars')
  is3StarClass: (-> @get('stars') >= 3).property('stars')
  is4StarClass: (-> @get('stars') >= 4).property('stars')
  is5StarClass: (-> @get('stars') == 5).property('stars')
  adjective: DS.attr('string')
  negativeAdjective: DS.attr('string')
  topic: DS.attr('string')
  scope: DS.attr('string')
  rankingAdjective: DS.attr('string')
  rankingNegativeAdjective: DS.attr('string')
  rankingTopic: DS.attr('string')
  rankingScope: DS.attr('string')
  userName: DS.attr('string')
  
  url: (->
    '/users/' + @get('user.id') + '/ranking_items'
  ).property('user')
  
  positiveOrNegativeAdjective: Ember.computed('rankingAdjective', 'rankingNegativeAdjective', 'best', ->
    if @get('best')
      @get('rankingAdjective')
    else
      @get('rankingNegativeAdjective')
  )