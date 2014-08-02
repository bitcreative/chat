`import Ember from 'ember'`

Router = Ember.Router.extend {
    location: FirebaseChatENV.locationType
}

Router.map ->
    @route 'login'

`export default Router`
