import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fading-in"
export default class extends Controller {
  static targets = ["card1","card2","card3","card4"]
  connect() {
    console.log("Hi Edyta - fading in controller");
    window.addEventListener('scroll',(event) => {
      console.log('Scrolling...');
    });
  }
  update(){
    window.addEventListener('scroll',(event) => {
      this.card1Target.classList.add('display-true');
      setTimeout(() => {
        this.card2Target.classList.add('display-true');
      }, 2000);
      setTimeout(() => {
        this.card3Target.classList.add('display-true');
      }, 4000);
      setTimeout(() => {
        this.card4Target.classList.add('display-true');
      }, 6000);
    })
  }
}
