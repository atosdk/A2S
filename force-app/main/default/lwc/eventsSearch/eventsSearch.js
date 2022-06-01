/* eslint-disable @lwc/lwc/no-api-reassignments */
import { LightningElement, api, wire } from "lwc";
import { getPicklistValues, getObjectInfo } from "lightning/uiObjectInfoApi";
import USER_OBJECT from "@salesforce/schema/User";
import TEAM_FIELD from "@salesforce/schema/User.Team__c";

export default class EventsSearch extends LightningElement {
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

  @api monthvalue = 0; //this.currMonth;
  @api month = "Select Month"; //this.allMonths[this.currMonth];
  @api team = "Salesforce";
  @api teamvalue = 0;
  picklistOptions = [];

  @wire(getObjectInfo, { objectApiName: USER_OBJECT }) userMetadata;

  @wire(getPicklistValues, {
    recordTypeId: "$userMetadata.data.defaultRecordTypeId",
    fieldApiName: TEAM_FIELD
  })
  teamPicklist({ error, data }) {
    if (data) {
      this.picklistOptions = data.values.map((plValue, id) => {
        return {
          label: `${plValue.label}`,
          value: id
        };
      });
    } else if (error) {
      console.log("Error in getting picklist values!");
      console.log(error);
    }
  }

  get monthOptions() {
    return [
      { label: "Select Month", value: 0 },
      { label: "January", value: 1 },
      { label: "February", value: 2 },
      { label: "March", value: 3 },
      { label: "April", value: 4 },
      { label: "May", value: 5 },
      { label: "June", value: 6 },
      { label: "July", value: 7 },
      { label: "August", value: 8 },
      { label: "September", value: 9 },
      { label: "October", value: 10 },
      { label: "November", value: 11 },
      { label: "December", value: 12 }
    ];
  }

  handleChange(event) {
    this.monthvalue = event.detail.value;
    this.month = this.monthOptions[this.monthvalue].label;
  }

  handleTeamChange(event) {
    this.teamvalue = event.detail.value;
    this.team = this.picklistOptions[this.teamvalue].label;
    console.log(TEAM_FIELD);
  }
}
