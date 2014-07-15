Shop.ProductController = Ember.ObjectController.extend
  actions:
    add_to_cart: (product) ->
      @store.find('cart', 1).then (cart) =>
        line_item = product.get('line_item')
        if line_item?
          line_item.incrementProperty('count')
        else
          @store.createRecord 'line_item',
            product: product
            cart: cart 
            count: 1

Shop.ProductsIndexController = Ember.ArrayController.extend
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

Shop.CartController = Ember.ObjectController.extend
  actions:
    removeLineItem: (line_item) ->
      line_item.deleteRecord()
      line_item.save()

    checkout: ->
      @transitionToRoute 'introduction'

Shop.RegistrationController = Ember.ObjectController.extend 
  actions:
    create: (args) ->
      console.log args