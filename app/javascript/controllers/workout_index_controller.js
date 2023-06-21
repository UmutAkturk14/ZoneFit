import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="workout-index"
export default class extends Controller {
  connect() {
    console.log("Connected to Workouts#Index Controller");
  }
}
