`import Ember from 'ember';`

ENTER = 13

RoomView = Ember.View.extend
    classNames: ['room-detail']

    bindKeypress: Ember.on 'didInsertElement', () ->
        @$('textarea').on 'keydown', (event) =>
            if event.keyCode is ENTER
                event.preventDefault()
                controller = @get 'controller'
                controller.send 'sendMessage'

`export default RoomView;`
