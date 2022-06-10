import { LightningElement, api } from "lwc";
import getFields from "@salesforce/apex/A2S_FieldSelectionHandler.getFields";

export default class FieldSelectionTab extends LightningElement {
  @api objectname;
  options = [];
  values = [];
  requiredOptions = [];
  isFirst = true;
  fields;
  selectedRecords = [];

  async connectedCallback() {
    await this.fetchData();
  }

  handleChange(e) {
    this.fields = e.detail.value;

    const selectedEvent = new CustomEvent("fieldschange", {
      detail: {
        objectname: this.objectname,
        selected: this.fields
      }
    });

    this.dispatchEvent(selectedEvent);
  }

  handleSelectedRecords(event) {
    const selectedRecords = event.detail.value;

    console.log("Mid: " + selectedRecords[0].Id);
    this.selectedIds = selectedRecords;

    // eslint-disable-next-line guard-for-in
    // for(let id in event.detail.value) {

    //     this.selectedIds.push(id.Id);

    // }

    this.fetchData();

    const selectedEvent = new CustomEvent("selectedid", {
      detail: { value: this.selectedIds }
    });

    this.dispatchEvent(selectedEvent);
  }

  async fetchData() {
    await getFields({
      objectname: this.objectname,
      objectid: this.selectedIds[0].Id
    })
      .then((result) => {
        let data = JSON.parse(JSON.stringify(result));
        let lstOption = [];
        for (let i = 0; i < data.length; i++) {
          lstOption.push({
            value: data[i],
            label: data[i]
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
