`import Ember from 'ember'`

ApplicationRoute = Ember.Route.extend
    actions:
        willTransition: (transition) ->
            if not @session.get 'authenticated'
                @session.set 'previousTransition', transition
                @transitionTo 'about'

    beforeModel: (transition) ->
        if not @session.get 'authenticated'
            if transition.targetName isnt 'index'
                @session.set 'previousTransition', transition

            promise = @session.get 'checkSessionPromise.promise'

            if promise
                promise.then (user) =>
                    if user is null
                        @transitionTo 'about'
                    else
                        previous = @session.get 'previousTransition'
                        if previous
                            previous.retry()
                        else
                            @transitionTo 'dashboard'
                .catch () =>
                    @transitionTo 'about'

            promise

    watchForLogout: Ember.observer 'session.authenticated', ->
        if @session.get 'authenticated'
            previous = @session.get 'previousTransition'
            @transitionTo 'dashboard'
        else
            @transitionTo 'about'

`export default ApplicationRoute`
