import SessionService from '../services/session';

var SessionInitializer = {
    name: 'setup-session',

    initialize: function (container, app) {
        app.register('service:session', SessionService, {singleton: true, initialize: true});
        app.inject('route', 'session', 'service:session');
    }
};

export default SessionInitializer;