`import Ember from 'ember';`

OmnibusInitializer =
    name: 'setup-omnibus'

    initialize: (container, app) ->
        app.deferReadiness()

        Ember.$.getJSON 'api/omnibus/'
        .then (data) ->
            transport = window.SockJS;
            endpoint = data.OMNIBUS_ENDPOINT
            options =
                authToken: data.OMNIBUS_AUTH_TOKEN

            connection = new window.Omnibus transport, endpoint, options
            app.set 'connection', connection

            Ember.Object.reopen
                connection: connection

            app.advanceReadiness()

`export default OmnibusInitializer`
