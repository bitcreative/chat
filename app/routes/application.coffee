`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
    beforeModel: ->
        if not @session.get 'authenticated'
            @transitionTo 'login'

`export default ApplicationRoute`
