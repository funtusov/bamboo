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

  @resource 'city'
  @resource 'payment_type'
  @resource 'delivery_type'

  @resource '404', path: '*path'

Shop.ApplicationRoute = Ember.Route.extend
  model: -> @session.cart()

Shop.ProductsIndexRoute = Ember.Route.extend
  model: -> @store.find('product')

Shop.CartRoute = Ember.Route.extend
  model: -> @session.cart()

Shop.RegistrationRoute = Ember.Route.extend
  model: -> @session.user()

Shop.CityRoute = Ember.Route.extend
  model: -> @session.cart()