Volontariat.Ranking = DS.Model.extend
  adjective: DS.attr('string')
  negativeAdjective: DS.attr('string')
  topic: DS.attr('string')
  scope: DS.attr('string')
  thing_type: DS.attr('string')
  
Volontariat.Ranking.thingTypes = ['Thing', 'Place', 'Movie', 'Artist', 'Music Artist', 'Music Album', 'Music Track']