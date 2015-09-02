Volontariat.ThingController = Ember.Controller.extend
  name: ''
  
  actions:
    
    compare: ->
      @transitionToRoute('compare_things', @get('name'), @get('otherThingName'))
    
    addToComparisonList: ->
      list = []
      
      unless Cookies.get('thingComparisonList') == undefined
        list = Cookies.getJSON 'thingComparisonList'
        
        if list.length == 4
          alert Volontariat.t('things.show.limit_of_comparison_list')
          
          return false
          
      list.push @get('thingId')

      Cookies.set 'thingComparisonList', list, expires: 7
      @controllerFor('thing').set 'thingComparisonListCount', list.length
      @set 'onComparisonList', true
        
    removeFromComparisonList: ->
      list = jQuery.grep(Cookies.getJSON('thingComparisonList'), (id) =>
        id != @get('thingId')
      )
      
      Cookies.set 'thingComparisonList', list, expires: 7
      @controllerFor('thing').set 'thingComparisonListCount', list.length
      @set 'onComparisonList', false
      
    goToComparisonList: ->
      @transitionToRoute 'things_comparison_matrix'  
      
    close: ->
      @send "closeModal"