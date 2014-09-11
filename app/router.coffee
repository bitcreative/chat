`import Ember from 'ember'`

Router = Ember.Router.extend {
    location: ChatENV.locationType
}

Router.map ->
    @route 'about'
    @route 'dashboard'
    @route 'account'
    @route 'register'

    @resource 'organization', path: ':organization_id', ->
        @route 'room', path: ':room_key'

        @route 'manage'

    @resource 'room', path: 'room', ->
        @route 'detail', path: ':room_id'

`export default Router`
