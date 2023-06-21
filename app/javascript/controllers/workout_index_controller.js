import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workout-index"
export default class extends Controller {
  connect() {
    console.log("Connected to Workouts#Index Controller");
  }


  hoverButton(event) {
    const links = event.currentTarget.querySelectorAll('a');
    const icons = event.currentTarget.querySelectorAll('i');

    links.forEach((link) => link.classList.remove('d-none'));
    icons.forEach((icon) => icon.classList.remove('d-none'));classList.remove('d-none');
  }

  hideButton(event) {
    const links = event.currentTarget.querySelectorAll('a');
    const icons = event.currentTarget.querySelectorAll('i');

    links.forEach((link) => link.classList.add('d-none'));
    icons.forEach((icon) => icon.classList.add('d-none'));
  }
}
