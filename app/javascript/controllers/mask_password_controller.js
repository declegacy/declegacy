import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['input', 'show', 'hide']

  connect() {
    this.hidden = true
    this.reformat()
  }

  toggle(e) {
    e.preventDefault()

    this.hidden = !this.hidden 
    this.reformat()
  }

  reformat() {
    if (this.hidden) {
      this.showTarget.style.display = "none"
      this.hideTarget.style.display = "inline-block"
      this.inputTarget.style["-webkit-text-security"] = "circle";
    } else {
      this.showTarget.style.display = "inline-block"
      this.hideTarget.style.display = "none"
      this.inputTarget.style["-webkit-text-security"] = "none";
    }
  }
}
