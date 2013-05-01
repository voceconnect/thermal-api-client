WisP.CategoryMenuView = Backbone.View.extend

  events:
    'selectedCategory' : 'selectedCategory'

  initialize: (opts) ->
    @$label = @$el.find '.dropdown-toggle'
    @$menu = @$el.find '.dropdown-menu'
    @childTagName = if opts? and
      opts.childTagName? then opts.childTagName else "li"
    @selected = null
    @listenTo @collection, 'add', @renderOne

  renderOne: (model) ->
    menuItem = new WisP.CategoryMenuItemView
      model: model,
      tagName: @childTagName
    @$menu.append menuItem.render().$el

  selectedCategory: (event, model)->
    @selected = model
    @$label.find('.text').text model.get 'name'