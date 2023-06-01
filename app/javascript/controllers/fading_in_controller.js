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
      if (window.scrollY > 600) {
        this.card1Target.classList.add('display-true');
        // this.card1Target.classList.add('slide-from-right');
        setTimeout(() => {
          this.card2Target.classList.add('display-true');
          // this.card2Target.classList.add('slide-from-left');
        }, 1500);
        setTimeout(() => {
          this.card3Target.classList.add('display-true');
          // this.card3Target.classList.add('slide-from-right');
        }, 3000);
        setTimeout(() => {
          this.card4Target.classList.add('display-true');
          // this.card4Target.classList.add('slide-from-left');
        }, 4500);
      }
    })
  }
}
