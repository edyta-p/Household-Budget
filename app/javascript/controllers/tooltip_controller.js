import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets= ['picture', 'description']
  connect() {
    console.log("Hello !!!!!!!!!!!");
  }

  show () {
    console.log('Hi there');
    this.descriptionTarget.innerText = "I am back";
  }

  hide () {
    console.log('Bye');
    this.descriptionTarget.innerText = "Cheers";
    // this.descriptionTarget.classList.add("d-none");
  }
}
