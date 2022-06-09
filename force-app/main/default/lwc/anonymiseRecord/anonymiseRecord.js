import { LightningElement } from "lwc";
import anonymiseFields from "@salesforce/apex/A2S_FieldSelectionHandler.anonymiseFields";
import getFields from "@salesforce/apex/A2S_FieldSelectionHandler.getFields";

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

  options = [];

  async handleClick() {
    if (this.confirmed) {
      console.log("Ok");
    } else {
      //await this.fetchData('Account');
      anonymiseFields({
        objectname: "Account",
        selectedfields: this.fields[1].selected
      }) //{ fields: this.fields[1].selected })
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

  async fetchData(object) {
    await getFields({
      objectname: object
    })
      .then((result) => {
        let data = JSON.parse(JSON.stringify(result));
        let lstOption = [];
        for (let i = 0; i < data.length; i++) {
          lstOption.push(data[i].DeveloperName);
        }
        this.options = lstOption;
        //console.log(lstOption);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}
