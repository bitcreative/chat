var FirebaseInitializer = {
    name: 'setup-firebase',
    after: 'setup-session',

    initialize: function (container, app) {
        // TODO: find a cleaner way to setup a single firebase instance for both the adapter and the session
        var firebase = container.lookup('adapter:application').get('firebase');
        var session = container.lookup('service:session');

        session.set('firebase', firebase);
    }
};

export default FirebaseInitializer;