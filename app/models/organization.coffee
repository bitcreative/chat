`import BaseModel from './base'`

Organization = BaseModel.extend
    name: null
    users: null

    orgUsers: Ember.computed 'users', ->
        #

    owners: Ember.computed 'users', ->
        users = @get 'users'
        users.filterBy? 'isOwner'

`export default Organization`
