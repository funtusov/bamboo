Shop.Session = Em.Object.extend
  user: ->
    @container.lookup('store:main').find('user', gon.current_user_id)

  cart: ->
    @user().then (user) ->
      user.get('cart')

Em.onLoad 'Ember.Application', (Application) ->
  Application.initializer
    name: 'session'
    initialize: (container, application) -> 
      application.register('session:main', Shop.Session)
      application.inject('route', 'session', 'session:main')
      application.inject('controller', 'session', 'session:main')