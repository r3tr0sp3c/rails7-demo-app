import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="vat-search"
export default class extends Controller {

  static targets = ['vatField', 'textMuted', 'queryBtn']

  connect() {
  }

  query(e) {
    e.preventDefault()
    let msg = this.validate_vat(this.vatFieldTarget.value.trim())
    if (msg == null) {
      this.textMutedTarget.innerHTML = ''
      let vat = this.vatFieldTarget.value.trim()

      get(`/accounts/${vat}/vat_search`, {
        responseKind: "turbo-stream"
      })

    } else {
      this.textMutedTarget.innerHTML = msg
      this.vatFieldTarget.classList.add('error')
      setTimeout( () => {
        this.vatFieldTarget.classList.remove('error')
      }, 300)
    }
  }

  count() {
    let msg = this.validate_vat(this.vatFieldTarget.value.trim())
    if (msg == null) {
      this.queryBtnTarget.classList.remove('btn-secondary')
      this.queryBtnTarget.classList.add('btn-primary')
      this.textMutedTarget.innerHTML = ''
    } else {
      this.queryBtnTarget.classList.add('btn-secondary')
      this.queryBtnTarget.classList.remove('btn-primary')
      this.textMutedTarget.innerHTML = msg
    }

  }

  validate_vat(value) {
    let message

    if (value.length === 9) {
      message = null
    } else {
      message = 'Please enter 9 numeric digits.'
    }

    if (isNaN(Number(value))) {
      message = 'Please enter only numbers.'
    }

    return message
  }

}
