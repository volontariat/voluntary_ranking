Volontariat.ThingsComparisonMatrixRoute = Ember.Route.extend
  model: (params) ->
    if Cookies.get('thingComparisonList') == undefined
      []
    else
      argumentables = []
      
      $.each Cookies.getJSON('thingComparisonList'), (index, value) ->
        argumentables.push { type: 'Thing', id: value } 
      
      Ember.$.getJSON("/api/v1/arguments/matrix", argumentables: argumentables)