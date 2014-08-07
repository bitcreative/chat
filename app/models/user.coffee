`import BaseModel from './base'`

User = BaseModel.extend
    username: null
    email: null

    isOwner: null

    organization: null

    setUserOrganizationModel: Ember.on 'init', () ->
        org = @get 'organization'
        if org and org.id
            @store.find('organization', org.id).then (model) =>
                @set 'organization', model

`export default User`
