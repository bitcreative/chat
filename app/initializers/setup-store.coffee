`import { Store } from '../models/base'`

SessionInitializer = {
    name: 'setup-store'

    initialize: (container, app) ->
        app.register 'store:application', Store,
            singleton: true
            initialize: true

        app.inject 'route', 'store', 'store:application'
        app.inject 'controller', 'store', 'store:application'
        app.inject 'component', 'store', 'store:application'
        app.inject 'object', 'store', 'store:application'
        app.inject 'service', 'store', 'store:application'
        app.inject 'model', 'store', 'store:application'

        store = container.lookup 'store:application'

        app.set 'store', store

}

`export default SessionInitializer`
