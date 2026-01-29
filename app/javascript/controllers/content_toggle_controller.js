import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="content-toggle"
export default class extends Controller {
  static targets = ["section"]

  connect() {
    // Show the first section by default
    this.showSection("general")
  }

  toggle(event) {
    const category = event.currentTarget.dataset.category
    this.showSection(category)
  }

  showSection(category) {
    this.sectionTargets.forEach(element => {
      if (element.dataset.category === category) {
        element.classList.remove("hidden")
      } else {
        element.classList.add("hidden")
      }
    })
  }
}