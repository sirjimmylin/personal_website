import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "links"]

  connect() {
    this.generateTableOfContents()
  }

  generateTableOfContents() {
    const headers = this.contentTarget.querySelectorAll("h2, h3")
    
    if (headers.length === 0) {
      this.element.classList.add("hidden") // Hide TOC if no headers
      return
    }

    let html = "<ul class='space-y-2 text-sm'>"
    
    headers.forEach((header, index) => {
      // Create an ID for the header if it doesn't have one
      const id = "header-" + index
      header.id = id

      // Create the link
      const indent = header.tagName === "H3" ? "ml-4" : ""
      html += `<li class="${indent}">
                 <a href="#${id}" class="text-gray-600 hover:text-indigo-600 block transition-colors">
                   ${header.innerText}
                 </a>
               </li>`
    })

    html += "</ul>"
    this.linksTarget.innerHTML = html
  }
}