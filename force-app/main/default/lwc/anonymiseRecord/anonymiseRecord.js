import { LightningElement } from "lwc";
import anonymiseFields from "@salesforce/apex/A2S_FieldSelectionHandler.anonymiseFields";

export default class AnonymiseRecord extends LightningElement {
  fields = [
    { objectname: "User", selected: [] },
    { objectname: "Account", selected: [] },
    { objectname: "Contact", selected: [] },
    { objectname: "Lead", selected: [] },
    { objectname: "CampaignMember", selected: [] }
  ];

  //f =[];
  objects = ["User", "Account", "Contact", "Lead", "CampaignMember"];
  confirmed = false;

  /*
  for(const obj of this.objects) {
    this.f = [this.f, {objectname: obj, selected: []}]
  }
  */

  handleFieldsChange(e) {
    this.fields[this.objects.indexOf(e.detail.objectname)].selected = [
      ...e.detail.selected
    ];
  }

  handelCheckbox(e) {
    console.log(e.target.checked);
    this.confirmed = true;
  }

  // NOT NEEDED => ONLY FOR TESTING
  lsUsers;

  /*****************************
    
    TODO: Return toast
    TODO: Clear all selected (rerender component)

   ****************************/

  handleClick() {
    if (this.confirmed) {
      console.log("Ok");
    } else {
      anonymiseFields({ fields: this.fields[0].selected })
        .then((res) => {
          this.lsUsers = res;
        })
        .catch((err) => console.log(err.body.message));

      console.log(
        this.lsUsers
        // this.fields[0],
        // this.fields[1],
        // this.fields[2],
        // this.fields[3],
        // this.fields[4]
      );
    }
  }
}
