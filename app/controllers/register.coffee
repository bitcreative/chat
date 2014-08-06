RegisterController = Ember.Controller.extend
    user:
        email: null
        password: null
        passwordRepeat: null

    organization:
        name: null

    registrationError: false

    buttonDisabled: Ember.computed 'user.{email,password,passwordRepeat}', 'organization.{name}', ->
        user = @get 'user'
        organization = @get 'organization'

        missingText = not organization.name or not user.email
        missingPassword = not user.password
        notMatching = user.password isnt user.passwordRepeat

        return missingText or missingPassword or notMatching

    passwordWarning: Ember.computed 'user.{password,passwordRepeat}', ->
        password = @get 'user.password'
        repeat = @get 'user.passwordRepeat'
        password and repeat and password isnt repeat

    actions:
        submitForm: ->
            if not @get 'buttonDisabled'
                email = @get 'user.email'
                password = @get 'user.password'
                orgName = @get 'organization.name'

                @set 'registrationError', false
                @send "register", email, password, orgName

`export default RegisterController`
