Volontariat.ArgumentsNewView = Ember.View.extend
  didInsertElement: ->
    $('#thing_id').val(window.location.hash.substring(1).split('/')[2])
    
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