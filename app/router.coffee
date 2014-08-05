`import Ember from 'ember'`

Router = Ember.Router.extend {
    location: FirebaseChatENV.locationType
}

Router.map ->
    @route 'about'
    @route 'dashboard'

`export default Router`
