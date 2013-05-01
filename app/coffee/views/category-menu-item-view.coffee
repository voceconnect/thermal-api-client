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
    @$el.trigger "selectedCategory", [@model]