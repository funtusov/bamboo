@Shop = Ember.Application.create(
  LOG_TRANSITIONS: true
  DEBUG: true
  LOG_VIEW_LOOKUPS: true
)

Shop.ApplicationAdapter = DS.FixtureAdapter.extend()

Shop.Cart = DS.Model.extend

Shop.Product = DS.Model.extend
  name: DS.attr()
  img: DS.attr()
  description: DS.attr()
  color: DS.attr()
  fabric: DS.attr()
  made_in: DS.attr()
  price: DS.attr('number')
  line_items: DS.hasMany('lineItem')

Shop.Cart = DS.Model.extend
  line_items: DS.hasMany('line_items')

  products_count: ( ->
    sum = 0
    @get('line_items').forEach (line_item) ->
      sum += line_item.get('count')
    sum
  ).property("line_items.@each")

  subtotal: ( -> 
    sum = 0
    @get('line_items').forEach (line_item) ->
      sum += line_item.get('total')
    sum
  ).property("line_items.@each")

Shop.LineItem = DS.Model.extend
  product: DS.belongsTo('product')
  cart: DS.belongsTo('cart')
  count: DS.attr('number')
  total: Ember.computed 'product', 'count', ->
    @get('product').get('price') * @get('count')

Shop.Router.reopen
  location: 'history'

Shop.Router.map ->
  @resource 'products', ->
  @resource 'product', path: '/products/:product_id'

Shop.ProductController = Ember.ObjectController.extend
  actions:
    add_to_cart: (product) ->
      cart = @store.find('cart', 1)
      line_item = @store.createRecord 'line_item',
        product: product
        count: 1

      @store.find('cart', 1).then (cart) ->
        line_item.set('cart', cart)

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

Shop.ProductsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('product')