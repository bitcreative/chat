AccountRoute = Ember.Route.extend
    model: ->
        @store.find 'user', @session.get 'user.id'

`export default AccountRoute`
