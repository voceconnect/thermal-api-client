WisP.Terms = Backbone.Collection.extend

  initialize: (models, opts) ->
    @model = WisP.Term
    @taxonomy = if opts? and opts.taxonomy? then opts.taxonomy else "category"
    baseUrl = WisP.config.baseUrl
    @url = "#{baseUrl}/taxonomies/#{@taxonomy}/terms/"

  parse: (response) ->
    @found = response.found
    response.terms