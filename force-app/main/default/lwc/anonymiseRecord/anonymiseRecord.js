import { LightningElement, api } from "lwc";

export default class AnonymiseRecord extends LightningElement {
  @api fields = [
    { id: 1, name: "Name1" },
    { id: 2, name: "Name2" },
    { id: 3, name: "Name3" },
    { id: 4, name: "Name4" }
  ];
}
