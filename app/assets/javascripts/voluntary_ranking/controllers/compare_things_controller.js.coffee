Volontariat.CompareThingsController = Ember.ObjectController.extend
  leftThingName: '', rightThingName: ''
  
  actions:
    
    compare: ->
      @transitionToRoute('compare_things', @get('leftThingName'), @get('rightThingName'))