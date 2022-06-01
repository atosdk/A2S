import getAnniversaries from "@salesforce/apex/A2S_UserController.getAnniversaries";
import { LightningElement, wire, api } from "lwc";

export default class AnniversarySearch extends LightningElement {
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

  @wire(getAnniversaries, { month: "$value", team: "$team" }) users;
}
