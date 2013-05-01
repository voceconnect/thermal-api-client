WisP.CategoryMenuItemView = Backbone.View.extend

  className: 'category-menu-item'

  events:
    'click a' : 'select'

  initialize: ->
    @template = WisP.Templates['category-menu-item.html']

  render: ->
    @$el.html @template(@model.toJSON())
    @

  select: ->
    categorySelect = WisP.config.html.categorySelect
    @.trigger "selectedCategory", [@model, this]