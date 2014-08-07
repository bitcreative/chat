`import BaseModel from './base'`

Organization = BaseModel.extend
    name: null
    users: null

    owners: Ember.computed 'users', ->
        users = @get 'users'
        users.filterBy? 'isOwner'

`export default Organization`
