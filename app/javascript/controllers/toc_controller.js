import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Add "container" to the list of targets
  static targets = ["content", "links", "container"]

  connect() {
    this.generateTableOfContents()
  }

  generateTableOfContents() {
    // 1. Find all H2 and H3 headers inside the content area
    const headers = this.contentTarget.querySelectorAll("h2, h3")
    
    // 2. If no headers found...
    if (headers.length === 0) {
      // FIX: Only hide the TOC container (the sidebar box), NOT the whole page (this.element)
      if (this.hasContainerTarget) {
        this.containerTarget.classList.add("hidden")
      }
      return
    }

    // 3. Generate the links
    let html = "<ul class='space-y-2 text-sm'>"
    
    headers.forEach((header, index) => {
      const id = "header-" + index
      header.id = id

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