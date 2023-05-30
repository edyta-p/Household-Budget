import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fading-in"
export default class extends Controller {
  connect() {
    console.log("Hi Edyta - fading in controller");
  }
}
