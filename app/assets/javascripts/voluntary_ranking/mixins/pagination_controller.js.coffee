Volontariat.PaginationController = Em.Mixin.create
  pages: [], totalPages: 1, page: 1, metadata: null
  
  showFirstPageLink: (-> @get('page') != 1).property('page')
  showPreviousPageLink: (-> @get('page') - 1 > 0).property('page')
  previousPage: (-> @get('page') - 1).property('page')
  showNextPageLink: (-> @get('page') + 1 <= @get('totalPages')).property('page')
  nextPage: (-> @get('page') + 1).property('page')
  showLastPageLink: (-> @get('page') != @get('totalPages')).property('page')

  _goToPage: (page) ->
    page = parseInt(page)
    @set('page', page)
    @set('totalPages', (@get('metadata') || @store.metadataFor(@get('paginationResource'))).pagination.total_pages)
    pages = []; i = page - 4
    
    while i <= page
      pages.push i if i > 0
      i += 1
    
    i = page + 1
    
    while i <= page + 4
      pages.push i if i <= @get('totalPages')
      i += 1
      
    pages = pages.map((item) ->
      number: item
      isCurrent: item is page
    ) 
    
    @set('pages', pages)   
    
  actions:
    goToPage: (page) ->
      @_goToPage(page)

      switch @get('paginationRoute')
        when 'rankings.show', 'profile.rankings'
          @transitionToRoute @get('paginationRoute'), @get('adjective'), @get('negativeAdjective'), @get('topic'), @get('scope'), page
        when 'rankings.index', 'arguments.index'
          @transitionToRoute @get('paginationRoute'), @get('thingName'), page
        when 'compare_things.arguments'
          @transitionToRoute @get('paginationRoute'), @get('leftThingName'), @get('rightThingName'), @get('side'), page
        when 'ranking_item'
          @transitionToRoute @get('paginationRoute'), @get('thingName'), @get('positiveOrNegativeAdjective'), @get('topic'), @get('scope'), page
        when 'user'
          @transitionToRoute @get('paginationRoute'), @get('name'), page
    
    goToPageWithoutRedirect: (page) ->
      @_goToPage(page)