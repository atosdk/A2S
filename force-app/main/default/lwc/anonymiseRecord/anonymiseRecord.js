import { LightningElement, track } from "lwc";

export default class AnonymiseRecord extends LightningElement {
  @track fields = [];

  objects = ["User", "Account", "Contact", "Lead"];

  get allFields() {
    return this.fields.length ? this.fields : "none";
  }

  handleFieldsChange(e) {
    this.fields = e.detail;
  }
}
