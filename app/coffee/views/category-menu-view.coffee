WisP.CategoryMenuView = Backbone.View.extend

  initialize: ->
    @listenTo @collection, 'add', @renderOne

  renderOne: (model) ->
    menuItem = new WisP.CategoryMenuItemView({ model: model, tagName: 'li' });
    @$el.append(menuItem.render().$el);