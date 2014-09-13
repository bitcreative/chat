`import Ember from 'ember';`

`import ApplicationSerializer from './application';`

MessageSerializer = ApplicationSerializer.extend
    serialize: (message, options) ->
        data =
            sender: message.get 'sender.id'
            room: message.get 'room.id'
            text: message.get 'text'

        if options.includeId
            message.set 'id', message.get('id')

        return data

`export default MessageSerializer;`
