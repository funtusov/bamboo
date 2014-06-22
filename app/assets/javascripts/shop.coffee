@Shop = Ember.Application.create(
  LOG_TRANSITIONS: true
  DEBUG: true
  LOG_VIEW_LOOKUPS: true
)

Shop.ApplicationAdapter = DS.FixtureAdapter.extend
  queryFixtures: (fixtures, query, type) ->
    fixtures.filter (item) ->
      for prop of query
        if item[prop] != query[prop]
          return false
      return true
    # return fixtures

# Shop.Store = DS.Store.extend
#   adapter: Shop.ApplicationAdapter

Shop.Cart = DS.Model.extend

Shop.Product = DS.Model.extend
  name: DS.attr()
  img: DS.attr()
  description: DS.attr()
  color: DS.attr()
  fabric: DS.attr()
  made_in: DS.attr()
  price: DS.attr('number')
  line_items: DS.hasMany('line_item')

Shop.Cart = DS.Model.extend
  line_items: DS.hasMany('line_items')

  products_count: ( ->
    @get('line_items').reduce (t, li) ->
      t + li.get('count')
    , 0
  ).property("line_items.@each.count")

  subtotal: ( ->
    @get('line_items').reduce (t, li) ->
      t + li.get('total')
    , 0
  ).property("line_items.@each.total")

  isFull: ( ->
    @get("products_count") > 0
  ).property("products_count")

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
  @resource 'cart'
  @resource 'delivery'
  @resource 'payment'

  @resource 'introduction'
  @resource 'login'
  @resource 'registration'

  @resource '404', path: '*path'

Shop.ProductController = Ember.ObjectController.extend
  actions:
    add_to_cart: (product) ->
      @store.find('cart', 1).then (cart) =>
        @store.find('line_item', {product: product}).then (line_item) =>
          window.line_item = line_item
          if line_item.get('cart')
            console.log 'increment'
            line_item.incrementProperty 'count'
          else
            console.log 'create'
            window.line_item2 = @store.createRecord 'line_item',
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

Shop.ApplicationRoute = Ember.Route.extend
  model: ->
    @store.find('cart', 1)

Shop.ProductsIndexRoute = Ember.Route.extend
  model: ->
    @store.find('product')

Ember.Handlebars.helper 'money', (value, options) ->
  parts = value.toString().split(".")
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ")
  parts.join "."