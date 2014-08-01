var Session = Ember.Object.extend({
    firebase: null,
    firebaseAuth: null,
    user: null,

    authPromise: null,

    setupAuth: Ember.computed('firebase', function () {
        var firebase = this.get('firebase');
        if (firebase) {
            var firebaseAuth = new FirebaseSimpleLogin(firebase, _.bind(this.handleAuthenticationChange, this));

            this.set('firebaseAuth', firebaseAuth);
        }
    }),

    handleAuthenticationChange: function (error, user) {
        Ember.Logger.info("Auth change: ", user, error);
        this.set('user', user);
        if (this.authPromise) {
            if (error) {
                this.authPromise.reject(error);
            }
            else {
                this.authPromise.resolve(user);
            }
        }
    }
});

export default Session;