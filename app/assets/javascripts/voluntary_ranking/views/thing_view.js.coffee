Volontariat.ThingView = Ember.View.extend
  didInsertElement: ->
    $('input[data-autocomplete]').each (k, v) ->
      bloodhound = new Bloodhound(
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace("value")
        queryTokenizer: Bloodhound.tokenizers.whitespace
        remote: $(this).attr('data-autocomplete') + '?term=%QUERY'
      )
      bloodhound.initialize()
      $(v).typeahead null,
        displayKey: "name"
        source: bloodhound.ttAdapter()