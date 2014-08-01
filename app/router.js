import Ember from 'ember';

var Router = Ember.Router.extend({
  location: FirebaseChatENV.locationType
});

Router.map(function() {
});

export default Router;
