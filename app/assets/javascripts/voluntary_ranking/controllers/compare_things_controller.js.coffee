Volontariat.CompareThingsController = Ember.ObjectController.extend
  leftThingName: '', rightThingName: ''
  
  actions:
    
    compare: ->
      @transitionToRoute 'no_data'
      @transitionToRoute 'compare_things', @get('leftThingName'), @get('rightThingName')