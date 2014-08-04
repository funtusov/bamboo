Shop.ApplicationController = Em.ObjectController.extend
  currentUser: ( ->
    @store.find('user', gon.current_user_id)
  ).property('gon.current_user_id')

Shop.ProductController = Em.ObjectController.extend
  actions:
    add_to_cart: (product) ->
      @session.user().then (user) =>
        line_item = product.get('line_item')
        if line_item?
          line_item.incrementProperty('quantity')
          line_item.save()
        else
          line_item = @store.createRecord 'line_item',
            product: product
            cart: user.get('cart') 
            quantity: 1
          line_item.save()

Shop.ProductsIndexController = Em.ArrayController.extend
  queryParams: ['sortBy']
  sortBy: 'id'

  sortProperties: ( ->
    [@get("sortBy")]
  ).property("sortBy")

  sortById: -> (
    @get('sortBy') == 'id'
  ).property('sortBy')

  sortByName: -> (
    @get('sortBy') == 'name'
  ).property('sortBy')

  sortByPrice: -> (
    @get('sortBy') == 'price'
  ).property('sortBy')

Shop.CartController = Em.ObjectController.extend
  actions:
    removeLineItem: (line_item) ->
      line_item.deleteRecord()
      line_item.save()

    checkout: ->
      @session.user().then (user) =>
        @transitionToRoute if user.get('signed_in')
          'city'
        else
          'introduction'

Shop.RegistrationController = Em.ObjectController.extend 
  actions:
    update: (user) ->
      user.save()