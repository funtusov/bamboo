Shop.Router.reopen
  location: 'history'

Shop.Router.map ->
  @resource 'products', ->
  @resource 'product', path: '/products/:product_id'
  @resource 'cart'
  @resource 'delivery'
  @resource 'payment'

  @resource 'introduction'
  @resource 'login'
  @resource 'registration'
  @resource 'confirmation'
  @resource 'address'

  @resource '404', path: '*path'

Shop.ApplicationRoute = Ember.Route.extend
  model: ->
    @store.find('cart', 1)

Shop.ProductsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('product')