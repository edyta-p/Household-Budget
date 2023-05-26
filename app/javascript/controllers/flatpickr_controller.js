import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    console.log("flatpicker connected", this.element);
    flatpickr(".something", {
      enableTime: true,
    });
  }
}
