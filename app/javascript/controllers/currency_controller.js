import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.formatValue(this.element.value)
  }

  // Essa função será chamada sempre que o input mudar
  format(event) {
    let input = event.target.value.replace(/\D/g, "") // remove tudo que não é número
    if (input.length < 3) {
      input = input.padStart(3, "0") // garante ao menos 3 dígitos
    }

    const formatted = (parseInt(input, 10) / 100).toLocaleString("pt-BR", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })

    event.target.value = formatted
  }

  formatValue(value) {
    const onlyNumbers = value.replace(/\D/g, "")
    if (!onlyNumbers) return

    const formatted = (Number(onlyNumbers) / 100).toLocaleString("pt-BR", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })

    this.element.value = formatted
  }
}