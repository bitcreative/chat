RegisterRoute = Ember.Route.extend
    actions:
        register: (email, password, orgName) ->
            @session.register email, password
                .then (sessionUser) =>
                    organization = @store.createRecord 'organization', { name: orgName, owner: sessionUser.email }
                    organization.save().then =>
                        userModel = @store.createRecord 'user', { email, organization, firstName: '', lastName: '' }
                        userModel.save().then =>
                            @transitionTo 'dashboard'

                .catch (error) =>
                    @controllerFor('register').set 'registrationError', error

            return

`export default RegisterRoute`
