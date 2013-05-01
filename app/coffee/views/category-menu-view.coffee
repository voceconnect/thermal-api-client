WisP.CategoryMenuView = Backbone.View.extend

  events:
    'selected:category' : 'selectedCategory'

  initialize: (opts) ->
    _.bindAll @, "selected"
    @$label = @$el.find '.dropdown-toggle'
    @$menu = @$el.find '.dropdown-menu'
    @childTagName = if opts? and
      opts.tagName? then opts.tagName else "li"
    @selected = null
    @listenTo @collection, 'add', @renderOne

  renderOne: (model) ->
    menuItem = new WisP.CategoryMenuItemView
      model: model,
      tagName: @childTagName
    @$menu.append menuItem.render().$el

  selected: (model)->
    @selected = @model
    @label.text @model.name