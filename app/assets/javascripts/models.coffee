Shop.Product = DS.Model.extend
  name: DS.attr()
  img: DS.attr()
  description: DS.attr()
  color: DS.attr()
  fabric: DS.attr()
  made_in: DS.attr()
  price: DS.attr('number')
  line_item: DS.belongsTo('line_item')

Shop.Cart = DS.Model.extend
  line_items: DS.hasMany('line_items')
  user: DS.belongsTo('user')

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

Shop.User = DS.Model.extend
  email: DS.attr 'string'
  cart: DS.belongsTo('cart')

Shop.ProductAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'

Shop.CartAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'

Shop.UserAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'