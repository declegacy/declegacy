import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resize() {
    this.element.style.height = "auto";  // Reset the height
    this.element.style.height = `${this.element.scrollHeight}px`;  // Set it to the scroll height
  }

  connect() {
    this.resize();  // Adjust height on load in case there's pre-filled content
  }
}
