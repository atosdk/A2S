import { LightningElement } from "lwc";
import anonymiseFields from "@salesforce/apex/A2S_FieldSelectionHandler.anonymiseFields";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class AnonymiseRecord extends LightningElement {
  fields = [
    { objectname: "User", selected: [] },
    { objectname: "Account", selected: [] },
    { objectname: "Contact", selected: [] },
    { objectname: "Lead", selected: [] },
    { objectname: "CampaignMember", selected: [] }
  ];

  objects = ["User", "Account", "Contact", "Lead", "CampaignMember"];
  selectedIds = [];
  lastObject;
  confirmed = false;

  handleFieldsChange(e) {
    this.fields[this.objects.indexOf(e.detail.objectname)].selected = [
      ...e.detail.selected
    ];

    this.lastObject = e.detail.objectname;
  }

  handleSelectedId(event) {
    const selectedRecords = event.detail.value;

    console.log("Top; " + selectedRecords[0].Id);

    this.selectedIds = selectedRecords;
  }

  handelCheckbox(e) {
    console.log(e.target.checked);
    this.confirmed = true;
  }

  /*****************************
    
    TODO: Return toast
    TODO: Clear all selected (rerender component)

   ****************************/

  options = [];

  handleClick() {
    anonymiseFields({
      objectname: this.lastObject,
      selectedfields:
        this.fields[this.objects.indexOf(this.lastObject)].selected,
      objectid: this.selectedIds[0].Id
    })
      .then((res) => {
        console.log(res);

        const notification = new ShowToastEvent({
          title: "Success!",
          message:
            "Fields for " +
            this.lastObject +
            " (ID: " +
            this.selectedIds[0].Id +
            ") were successfully anonymised.",
          variant: "success",
          mode: "dismissable"
        });

        this.dispatchEvent(notification);
      })
      .catch((err) => {
        console.log(err.body.message);

        const notification = new ShowToastEvent({
          title: "Error",
          message: "Please check fields and try again.",
          variant: "error",
          mode: "dismissable"
        });

        this.dispatchEvent(notification);
      });
  }
}
