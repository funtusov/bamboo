@Shop = Ember.Application.create(
  LOG_TRANSITIONS: true
  DEBUG: true
  LOG_VIEW_LOOKUPS: true
)

Shop.ApplicationAdapter = DS.FixtureAdapter.extend()

Shop.Product = DS.Model.extend
  title: DS.attr()
  img: DS.attr()
  description: DS.attr()
  color: DS.attr()
  fabric: DS.attr()
  made_in: DS.attr()
  price: DS.attr('number')

Shop.Router.reopen
  location: 'history'

Shop.Router.map ->
  @resource 'products', ->
  @resource 'product', path: '/products/:product_id'

Shop.ProductsIndexController = Ember.ArrayController.extend
  queryParams: ['sortBy']
  sortBy: 'id'

  sortProperties: ( ->
    [@get("sortBy")]
  ).property("sortBy")

Shop.ProductsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('product')