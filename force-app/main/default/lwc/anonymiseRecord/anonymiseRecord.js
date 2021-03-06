import { LightningElement } from "lwc";

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

  handleClick() {
    if (this.confirmed) {
      // eslint-disable-next-line no-alert
      alert("Selected fields: \n" + this.fields);
    } else {
      console.log(
        this.fields[0],
        this.fields[1],
        this.fields[2],
        this.fields[3],
        this.fields[4]
      );
    }
  }
}