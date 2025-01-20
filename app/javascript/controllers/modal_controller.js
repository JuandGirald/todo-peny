import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  close(event) {
    if (event) event.preventDefault()
    this.element.remove()
  }

  disconnect() {
    this.close()
  }

  clickOutside(event) {
    if (event.target === this.dialogTarget) {
      this.close(event)
    }
  }
}
