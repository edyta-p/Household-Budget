import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-cards"
export default class extends Controller {
  static targets = ["info"]

  connect() {
    console.log('I am there')
  }

  display(event) {
    console.log("Hey button");
    event.preventDefault();
    // this.cardTarget.classList.remove("d-none");
    this.infoTarget.classList.remove("d-none");
    // this.shopTarget.classList.remove("d-none");
    // this.descrTarget.classList.remove("d-none");
    };

  hide(event) {
    console.log("Bye button");
    event.preventDefault();
    // this.cardTarget.classList.remove("d-none");
    this.infoTarget.classList.add("d-none");
    // this.shopTarget.classList.add("d-none");
    // this.descrTarget.classList.add("d-none");
    };
  }
