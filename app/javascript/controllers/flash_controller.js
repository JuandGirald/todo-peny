import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Automatically hide the flash message after 5 seconds
    setTimeout(() => {
      this.close()
    }, 5000)
  }

  close(event) {
    if (event) event.preventDefault()
    this.element.remove()
  }
}
