Volontariat.NewArgumentComponent = Ember.Component.extend
  didInsertElement: ->
    $('input[data-append-autocomplete]').each (k, v) ->
      $(v).autocomplete
        source: $(this).attr('data-append-autocomplete'),
        appendTo: '#topic_suggestions'
        select: (event, ui) ->
          $(this).val(ui.item.value)
          false
