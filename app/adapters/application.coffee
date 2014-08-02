`import DS from 'ember-data'`

ApplicationAdapter = DS.FirebaseAdapter.extend {
    firebase: new Firebase 'https://thebestfriendsgang.firebaseio.com'
}

`export default ApplicationAdapter`
