import { LightningElement } from "lwc";
import getFields from "@salesforce/apex/A2S_FieldSelectionHandler.getFields";

export default class AnonymiseRecord extends LightningElement {
  options = [];
  values = [];
  requiredOptions = [];
  isFirst = true;
  _fields = [];

  async connectedCallback() {
    await this.fetchData();
  }

  get fields() {
    return this._fields.length ? this._fields : "";
  }

  handleChange(e) {
    this._fields = e.detail.value;
  }

  async fetchData() {
    await getFields({
      objectname: "User"
    })
      .then((result) => {
        let data = JSON.parse(JSON.stringify(result));
        let lstOption = [];
        for (let i = 0; i < data.length; i++) {
          lstOption.push({
            value: data[i].QualifiedApiName,
            label: data[i].DeveloperName
          });
        }
        this.options = lstOption;
        console.log(lstOption);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}
