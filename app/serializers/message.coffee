`import Ember from 'ember';`

`import ApplicationSerializer from './application';`

MessageSerializer = ApplicationSerializer.extend
    attrs:
        sender: serialize: 'id'
        room: serialize: 'id'

    serialize: (message, options) ->
        data =
            text: message.get 'text'

        extra = message.get '_extra'
        data.room = extra.room.get 'id'
        data.sender = extra.sender.get 'id'

        if options.includeId
            message.set 'id', message.get('id')

        return data

`export default MessageSerializer;`
