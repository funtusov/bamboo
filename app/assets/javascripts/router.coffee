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
  model: ->
    @store.find('user', gon.current_user_id).then (user) =>
      user.get('cart')

Shop.ProductsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('product')

Shop.CartRoute = Ember.Route.extend
  model: ->
    @store.find('user', gon.current_user_id).then (user) =>
      user.get('cart')

Shop.RegistrationRoute = Ember.Route.extend
  model: ->
    @store.find('user', gon.current_user_id)

Shop.CityRoute = Ember.Route.extend
  model: ->
    @store.find('user', gon.current_user_id).then (user) =>
      user.get('cart')