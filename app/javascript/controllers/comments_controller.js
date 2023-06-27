import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comments"
export default class extends Controller {
  connect() {
    console.log("Connecting to data-controller")
  }

  clickButton(event) {
    event.preventDefault();
    // console.log("Button clicked");
    // console.log(event.currentTarget.closest(".post"));
    const parentElement = event.currentTarget.closest('#post');
    const nestedCommentsElement = parentElement.querySelector('.nested-comments');

    nestedCommentsElement.classList.toggle('d-none');
  }
}
