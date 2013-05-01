WisP.Term = Backbone.Model.extend

  defaults:
    id: 0
    parent: 0
    name: ''
    slug: ''
    taxonomy: ''
    description: ''
    count: 0

  initialize: ( atts, options ) ->

  urlRoot: () =>
    "#{WisP.config.baseUrl}/taxonomy/#{this.taxonomy}/terms/"