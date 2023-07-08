import { Controller } from "@hotwired/stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['notificationCount'];

  connect() {
    this.refreshCount();
    this.startRefreshing();
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.refreshCount();
    }, 1000); // Refresh every 5 seconds (adjust as needed)
  }

  stopRefreshing() {
    clearInterval(this.refreshTimer);
  }

  refreshCount() {
    Rails.ajax({
      url: '/chatroom/notifications_count', // Replace with your actual route to the action in ChatroomController
      type: 'GET',
      dataType: 'json',
      success: (data) => {
        this.notificationCountTarget.innerHTML = `Unread messages: ${data.count}`;
      },
      error: (xhr, status, error) => {
        console.error(error);
      }
    });
  }
}
