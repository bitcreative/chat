FirebaseInitializer = {
    name: 'setup-firebase'
    after: 'setup-session'

    initialize: (container) ->
        # TODO: find a cleaner way to setup a single firebase instance for both the adapter and the session
        session = container.lookup 'service:session'
        adapter = container.lookup 'adapter:application'
        session.set 'firebase', adapter.get 'firebase'
}

`export default FirebaseInitializer`
