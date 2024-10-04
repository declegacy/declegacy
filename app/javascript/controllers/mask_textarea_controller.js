import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'show', 'hide']

  connect() {
    this.hidden = false
    this.reformat()
  }

  toggle(e) {
    e.preventDefault()

    this.hidden = !this.hidden 
    this.reformat()
  }

  hide() {
    this.hidden = true 
    this.reformat()
  }

  show() {
    this.hidden = false 
    this.reformat()
  }

  reformat() {
    if (this.hidden) {
      this.showTarget.style.display = "none"
      this.hideTarget.style.display = "inline-block"
      // this.inputTarget.style["-webkit-text-security"] = "circle";
      this.hideTextContent(this.inputTarget)
    } else {
      this.showTarget.style.display = "inline-block"
      this.hideTarget.style.display = "none"
      this.showTextContent(this.inputTarget);
    }
  }

  hideTextContent(input) {
    // this.inputTarget.style["-webkit-text-security"] = "circle";
    input.style["text-shadow"] = "0 0 5px rgba(0,0,0,0.5)";
    input.style["color"] = "transparent";
  }
  showTextContent(input) {
    input.style["text-shadow"] = "none"
    input.style["color"] = null;
  }
}
