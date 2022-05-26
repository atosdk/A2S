import getAnniversaries from '@salesforce/apex/A2S_UserController.getAnniversaries';
import { LightningElement, wire, api } from 'lwc';

export default class AnniversarySearch extends LightningElement {

    @api value = 11;
    @api label = 'November';
    
    @wire(getAnniversaries, {month: '$value' }) users;

}