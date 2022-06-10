import { LightningElement, api } from "lwc";
import getUsers from "@salesforce/apex/A2S_UserSearch.getUsers";

export default class UserSearch extends LightningElement {
  @api objectname;
  selectedIds = [];
  key;
  //@track users;
  updateKey(event) {
    this.key = event.target.value;
  }
  users = [];

  //@wire(getUsers, {searchKey: '$key', objectname : this.objectname }) users;

  handleClick() {
    console.log(this.objectname);

    getUsers({ searchKey: this.key, objectname: this.objectname })
      .then((res) => {
        this.users = res;
        //console.log(this.users);
      })
      .catch((err) => console.error(err));
  }

  getSelectedId(event) {
    const selectedRows = event.detail.selectedRows;

    this.selectedIds = selectedRows;
    console.log(this.selectedIds);
  }

  // handleSearch(){
  //     getUsers({searchKey: this.key})
  //     .then(result=>{
  //         this.users = result;
  //     })
  //     .catch(error=>{
  //         this.users = null;
  //     });
  // }

  cols = [
    { label: "Name", fieldName: "Name", type: "text" },
    { label: "Id", fieldName: "Id", type: "text" }
  ];
}
