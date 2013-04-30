WisP.Term = Backbone.Model.extend

  defaults:
    id: null
    title: ''
    slug: ''
    taxonomy: ''
    description: ''
    count: 0
    
  initialize: ( atts, options ) ->

  urlRoot: () =>
    "#{WisP.config.baseUrl}/taxonomy/#{this.taxonomy}"