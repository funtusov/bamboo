Shop.ApplicationController = Ember.ObjectController.extend
  currentUser: ( ->
    @store.find('user', gon.current_user_id)
  ).property('gon.current_user_id')

Shop.ProductController = Ember.ObjectController.extend
  actions:
    add_to_cart: (product) ->
      @store.find('user', gon.current_user_id).then (user) =>
        line_item = product.get('line_item')
        if line_item?
          line_item.incrementProperty('count')
        else
          @store.createRecord 'line_item',
            product: product
            cart: user.get('cart') 
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
      @store.find('user', gon.current_user_id).then (user) =>
        if user.get('signed_in')
          @transitionToRoute 'city'
        else
          @transitionToRoute 'introduction'

Shop.RegistrationController = Ember.ObjectController.extend 
  actions:
    create: (user) ->
      user.save()
      # @store.find('user', gon.current_user_id).then (user) =>
      #   user.setProperties
      #     first_name: args.first_name
      #     last_name: args.last_name
      #     email: args.email
      #     password: args.password
      #     password_confirmation: args.password_confirmation
      #   user.save()