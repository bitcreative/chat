RegisterController = Ember.Controller.extend
    user:
        email: null
        password: null
        passwordRepeat: null


    organization:
        name: null

    buttonDisabled: Ember.computed 'user.{email,password,passwordRepeat}', 'organization.{name}', ->
        user = @get 'user'
        organization = @get 'organization'

        missingText = not organization.name or not user.email
        missingPassword = not user.password?
        notMatching = user.password isnt user.passwordRepeat


        return missingText or missingPassword or notMatching

    actions:
        register: ->
            user = @get 'user'
            organization = @get 'organization'

            org = @store.createRecord 'organization', organization

            @session.register user.email, user.password
                .then (userData) =>
                    org.set 'owner', userData.email
                    org.save()
                        .then () =>
                            user = @store.createRecord 'user', userData
                            user.set 'organization', org
                            user.setProperties
                                firstName: ''
                                lastName: ''
                            user.save()

                .catch (error) =>
                    # error yo!

            return


`export default RegisterController`
