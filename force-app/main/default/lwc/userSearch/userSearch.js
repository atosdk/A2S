import { LightningElement, api } from "lwc";
import getUsers from "@salesforce/apex/A2S_UserSearch.getUsers";

export default class UserSearch extends LightningElement {
  @api objectname;
  selectedIds = [];
  users = [];
  key;

  updateKey(event) {
    this.key = event.target.value;
  }

  handleClick() {
    getUsers({ searchKey: this.key, objectname: this.objectname })
      .then((res) => {
        this.users = res;
      })
      .catch((err) => console.error(err));
  }

  handleSelect() {
    console.log(this.selectedIds);
    const selectedEvent = new CustomEvent("selectedrecords", {
      detail: { value: this.selectedIds }
    });

    this.dispatchEvent(selectedEvent);
  }

  getSelectedId(event) {
    this.selectedIds = event.detail.selectedRows;
  }

  cols = [
    { label: "Name", fieldName: "Name", type: "text" },
    { label: "Id", fieldName: "Id", type: "text" }
  ];
}
