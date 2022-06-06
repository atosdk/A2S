import { LightningElement } from "lwc";

export default class AnonymiseRecord extends LightningElement {
  fields = [];

  objects = ["User", "Account", "Contact", "Lead"];

  get allFields() {
    return this.fields.length ? this.fields : "none";
  }

  handleFieldsChange(e) {
    this.fields = [...e.detail];
  }

  handleClick() {
    // eslint-disable-next-line no-alert
    alert("Selected fields: \n" + this.fields);
  }
}
