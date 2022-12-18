import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets  = ['notification']

  connect() {
  }

  dismiss(e) {
    e.target.remove()
  }
}
