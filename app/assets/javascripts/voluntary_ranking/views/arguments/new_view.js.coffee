Volontariat.ArgumentsNewView = Ember.View.extend
  didInsertElement: ->
    $('input[data-autocomplete]').each (k, v) ->
      $(v).autocomplete
        source: $(this).attr('data-autocomplete'),
        appendTo: '#topic_suggestions'
        select: (event, ui) ->
          $(this).val(ui.item.value)
          false