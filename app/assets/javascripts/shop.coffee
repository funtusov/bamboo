@Shop = Ember.Application.create(
  LOG_TRANSITIONS: true
  DEBUG: true
  LOG_VIEW_LOOKUPS: true
)

Shop.ApplicationAdapter = DS.FixtureAdapter.extend
  queryFixtures: (fixtures, query, type) ->
    key = Ember.keys(query)[0]
    return fixtures.filterBy(key, query[key])