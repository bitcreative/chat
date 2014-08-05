`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
    beforeModel: ->
        if not @session.get 'authenticated'
            @transitionTo 'about'

    actions:
        willTransition: ->
            if not @session.get 'authenticated'
                @transitionTo 'about'

    watchForLogout: Ember.observer 'session.authenticated', ->
        if @session.get 'authenticated'
            @transitionTo 'dashboard'
        else
            @transitionTo 'about'

`export default ApplicationRoute`
