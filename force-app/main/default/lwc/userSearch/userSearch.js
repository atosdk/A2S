import { LightningElement, track } from 'lwc';
import getUsers from "@salesforce/apex/A2S_UserSearch.getUsers";

export default class UserSearch extends LightningElement {
    key;
    @track users;
    updateKey(event){
        this.key = event.target.value;
    }

    handleSearch(){
        getUsers({searchKey: this.key})
        .then(r=>{

        })
        .catch();
    }
}