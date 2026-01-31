import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "button"]
  static values = { open: Boolean }

  connect() {
    this.updateState()
  }

  toggle() {
    this.openValue = !this.openValue
    this.updateState()
  }

  updateState() {
    if (this.openValue) {
      this.contentTarget.classList.remove("hidden")
      this.buttonTarget.innerText = "Hide"
    } else {
      this.contentTarget.classList.add("hidden")
      this.buttonTarget.innerText = "Show" // or whatever default text you want
    }
  }
}