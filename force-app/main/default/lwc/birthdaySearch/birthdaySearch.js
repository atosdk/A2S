import { LightningElement, wire, api } from 'lwc';
import getBirthdays from '@salesforce/apex/A2S_UserController.getBirthdays';

export default class BirthdaySearch extends LightningElement {

    @api value = 11;
    @api label = 'November';
    
    @wire(getBirthdays, {month: '$value' }) users;

    
}