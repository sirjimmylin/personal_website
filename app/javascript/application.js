// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const renderMath = () => {
  if (window.renderMathInElement) {
    window.renderMathInElement(document.body, {
      delimiters: [
        { left: "$$", right: "$$", display: true },
        { left: "$", right: "$", display: false }
      ]
    })
  }
}

const highlightCode = () => {
  if (window.hljs) {
    window.hljs.highlightAll()
  }
}

document.addEventListener("turbo:load", () => {
  renderMath()
  highlightCode()
})
