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
      t + li.get('quantity')
    , 0
  ).property("line_items.@each.quantity")

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
  quantity: DS.attr('number')
  total: Em.computed 'product', 'quantity', ->
    @get('product').get('price') * @get('quantity')

  persistQuantity: ( ->
    Em.run.debounce(this, @save, 500) if @get('isDirty')  
  ).observes('quantity')

Shop.User = DS.Model.extend
  signed_in: DS.attr 'boolean'
  email: DS.attr 'string'
  first_name: DS.attr 'string'
  last_name: DS.attr 'string'
  cart: DS.belongsTo 'cart'
  password: DS.attr()
  password_confirmation: DS.attr()