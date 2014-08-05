`import DS from 'ember-data'`

ApplicationAdapter = DS.FirebaseAdapter.extend
    firebase: new Firebase 'https://chatandstuff.firebaseio.com'


`export default ApplicationAdapter`
