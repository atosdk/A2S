import { LightningElement, api } from "lwc";
import getFields from "@salesforce/apex/A2S_FieldSelectionHandler.getFields";

export default class FieldSelectionTab extends LightningElement {
  @api objectname;
  options = [];
  values = [];
  requiredOptions = [];
  isFirst = true;
  //@api fields;

  async connectedCallback() {
    await this.fetchData();
  }

  handleChange(e) {
    const fields = e.detail.value;

    const selectedEvent = new CustomEvent("fields", {
      detail: fields
    });

    this.dispatchEvent(selectedEvent);
  }

  async fetchData() {
    await getFields({
      objectname: this.objectname
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
