import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-cards"
export default class extends Controller {
  static targets = ["date", "shop", "descr"]

  connect() {
    console.log('I am there')
  }

  display() {
    console.log("Hey button");
    // this.cardTarget.classList.remove("d-none");
    this.dateTarget.classList.remove("d-none");
    this.shopTarget.classList.remove("d-none");
    this.descrTarget.classList.remove("d-none");
    };

  hide() {
    console.log("Bye button");
    // this.cardTarget.classList.remove("d-none");
    this.dateTarget.classList.add("d-none");
    this.shopTarget.classList.add("d-none");
    this.descrTarget.classList.add("d-none");
    };
  }
