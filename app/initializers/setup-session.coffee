`import SessionService from '../services/session'`

SessionInitializer = {
    name: 'setup-session'

    initialize: (container, app) ->
        Parse.initialize app.PARSE_APP_KEY, app.PARSE_JS_KEY

        app.register 'service:session', SessionService,
            singleton: true
            initialize: true

        app.inject 'route', 'session', 'service:session'
        app.inject 'controller', 'session', 'service:session'
        app.inject 'component', 'session', 'service:session'
}

`export default SessionInitializer`
