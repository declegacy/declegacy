import { Controller } from "@hotwired/stimulus"
import { getShortSHA256Hash } from "./shared_methods.js"

export default class extends Controller {
  static targets = ['encryptionPassword', "hasVerifiedPassword"]
  static values = { shortPasswordHash: String }

  connect() {
    
  }

  async onPasswordInput(event) {
    event.preventDefault(); 
  }

  async onSubmit(event) {
    let calculatedHash = await getShortSHA256Hash(this.encryptionPasswordTarget.value)
    if(this.shortPasswordHashValue == calculatedHash) {
      this.hasVerifiedPasswordTarget.value = 1
      this.encryptionPasswordTarget.value = "" // make sure not to send the value to the server
      this.element.submit()
    } else {
      alert("Incorrect password!")
    }
  }


}
