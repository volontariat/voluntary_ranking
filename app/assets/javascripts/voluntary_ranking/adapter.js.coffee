VoluntaryOnEmberjs.Adapter = DS.RESTAdapter.extend
  findQuery: (store, type, query, recordArray) ->
    root = @rootForType(type)
    url = @buildURL(root)
    
    if type.toString().match('UserRankingItem')
      url = url.split('api')
      url = '/api/users/' + query['user_id'] + url[1]
      delete query['user_id']
    
    if type.toString().match('RankingItem')
      camelCaseAttributes = { 
        'thingType': 'thing_type', 'negativeAdjective': 'negative_adjective'
      }
      
      $.each camelCaseAttributes, (camelCaseAttribute, attribute) =>
        query[attribute] = query[camelCaseAttribute]
        delete query[camelCaseAttribute]
        
    adapter = this
    
    @ajax(url, 'GET',
      data: query
    ).then (json) ->
      Ember.run adapter, ->
        @didFindQuery store, type, json, recordArray
        
  createRecord: (store, type, record) ->
    root = @rootForType(type)
    adapter = this
    
    data = {}
    data[root] = @serialize(record,
      includeId: true
    )
    root = @rootForType(type)
    
    url = if record.get("url") then record.get("url") else @buildURL(root)
    
    @ajax(url, "POST",
      data: data
    ).then ((json) ->
      Ember.run adapter, "didCreateRecord", store, type, record, json
    ), (xhr) ->
      adapter.didError store, type, record, xhr
      throw xhr
      
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.Ranking",
  alias: "ranking"

VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.RankingItem",
  alias: "ranking_item"

VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.UserRankingItem",
  alias: "user_ranking_item"
     
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.Thing",
  alias: "thing"
     
VoluntaryOnEmberjs.Adapter.configure "VoluntaryOnEmberjs.Movie",
  alias: "movie" 