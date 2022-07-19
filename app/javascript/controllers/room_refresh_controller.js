import { Controller } from "@hotwired/stimulus"
import { cable } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    this.subscribe()
    this.scrollMessages()
  }

  subscribe() {
    const turboCableStreamTag = document.querySelector("turbo-cable-stream-source")
    const signedStreamName =  turboCableStreamTag.getAttribute("signed-stream-name")
    const channelName =  turboCableStreamTag.getAttribute("channel")

    const scrollMessages = this.scrollMessages.bind(this)

    this.channel = cable.subscribeTo({ ['channel']: channelName, ['signed-stream-name']: signedStreamName }, {
      received(data){
      }
    })
  }

  clearInput() {
    this.element.reset()
  }

  scrollMessages() {
    const messageBox = document.getElementById("messageBox")
    if (messageBox) messageBox.scrollTop = messageBox.scrollHeight
  }
}
