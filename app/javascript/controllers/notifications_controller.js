import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "Noticed::NotificationChannel" },
      { received: data => console.log(data) }
    )
    console.log(`Subscribed to the notifications stream.`)
  }
}
