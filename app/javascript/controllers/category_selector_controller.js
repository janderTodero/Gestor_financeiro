import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["entrada", "saida", "type"];

  connect() {
    this.toggle();
  }

  toggle() {
    const type = this.typeTarget.value;

    const entradaSelect = this.entradaTarget.querySelector("select");
    const saidaSelect = this.saidaTarget.querySelector("select");

    if (type === "entrada") {
      this.entradaTarget.style.display = "block";
      this.saidaTarget.style.display = "none";

      entradaSelect.disabled = false;
      saidaSelect.disabled = true;
    } else if (type === "saida") {
      this.entradaTarget.style.display = "none";
      this.saidaTarget.style.display = "block";

      entradaSelect.disabled = true;
      saidaSelect.disabled = false;
    } else {
      this.entradaTarget.style.display = "none";
      this.saidaTarget.style.display = "none";

      entradaSelect.disabled = true;
      saidaSelect.disabled = true;
    }
  }
}
