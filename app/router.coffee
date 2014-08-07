`import Ember from 'ember'`

Router = Ember.Router.extend {
    location: ChatENV.locationType
}

Router.map ->
    @route 'about'
    @route 'dashboard'
    @route 'account'
    @route 'register'

    @resource 'room', { path: 'room' }, ->
        @route 'detail', { path: ':room_id' }

`export default Router`
