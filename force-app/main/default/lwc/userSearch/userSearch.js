import { LightningElement, track, wire } from 'lwc';
import getUsers from "@salesforce/apex/A2S_UserSearch.getUsers";

export default class UserSearch extends LightningElement {
    key;
    @track users;
    updateKey(event){
        this.key = event.target.value;
    }

    @wire(getUsers, {searchKey: '$key'}) users;

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
        {label: 'Name', fieldName: 'Name', type: 'text'}
    ]
}