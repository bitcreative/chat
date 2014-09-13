`import Ember from 'ember';`
`import DS from 'ember-data';`

`import ApplicationSerializer from './application';`

RoomSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
    attrs:
        messages: embbeded: 'always'

`export default RoomSerializer;`
