SessionInitializer = {
    name: 'setup-store'

    initialize: (container, app) ->
        app.inject 'component', 'store', 'store:main'
        app.inject 'service', 'store', 'store:main'

        store = container.lookup 'store:main'

        app.set 'store', store

}

`export default SessionInitializer`
