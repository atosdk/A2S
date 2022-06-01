import { LightningElement, api, wire } from "lwc";
import getBirthdays from "@salesforce/apex/A2S_UserController.getBirthdays";

export default class BirthdaySearch extends LightningElement {
  d = new Date();
  currMonth = this.d.getMonth();
  allMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @api value = this.currMonth;
  @api label = this.allMonths[this.currMonth];
  @api team = "Salesforce";

  @wire(getBirthdays, { month: "$value", team: "$team" }) users;

  /*
    @track users;

    @wire(getBirthdays, {month: '$value', team:'$team' }) 
    objcurr({ data, error }) {
        if (data) {
            this.users = data;
            this.displayUserstoConsole(this.users);
        } else if (error) {
            console.log(error);
        }
    }

    displayUserstoConsole(currData) {
        console.log('currdata', JSON.stringify(currData));
    }
    */
}
