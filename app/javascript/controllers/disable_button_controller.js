import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disable-button"
export default class extends Controller {
  static targets = ["info", "eye","infoIcon","eyeIcon"]

  connect() {
    console.log('disabled button connected');
    console.log(this.infoTarget);
  }

  disableInfo(){
    this.infoTarget.setAttribute("disabled","");
    this.eyeTarget.removeAttribute("disabled","");
    this.infoIconTarget.classList.add("disabled");
    this.eyeIconTarget.classList.remove("disabled");
  }

  disableEye(){
    this.eyeTarget.setAttribute("disabled","");
    this.infoTarget.removeAttribute("disabled","");
    this.eyeIconTarget.classList.add("disabled");
    this.infoIconTarget.classList.remove("disabled");
  }
}
