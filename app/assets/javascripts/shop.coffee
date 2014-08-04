@Shop = Em.Application.create(
  LOG_TRANSITIONS: true
  DEBUG: true
  LOG_VIEW_LOOKUPS: true
)

Shop.ApplicationAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'