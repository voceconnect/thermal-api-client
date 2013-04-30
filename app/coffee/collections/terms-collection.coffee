WisP.Terms = Backbone.Collection.extend
  
  initialize: (models, options) ->
    @model = WisP.Term
    @taxonomy = if options? and options.taxonomy? then options.taxonomy else "category"
    baseUrl = WisP.config.baseUrl
    @url = "#{baseUrl}/taxonomies/#{@taxonomy}/terms/"

  parse: (response) ->
    @found = response.found
    response.terms