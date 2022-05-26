import { LightningElement, api } from 'lwc';

export default class EventsSearch extends LightningElement {

    @api value = 11;
    @api label = 'November';

    get options() {
        return [
            { label: 'Select Month', value: 0 },
            { label: 'January', value: 1 },
            { label: 'February', value: 2 },
            { label: 'March', value: 3 },
            { label: 'April', value: 4 },
            { label: 'May', value: 5 },
            { label: 'June', value: 6 },
            { label: 'July', value: 7 },
            { label: 'August', value: 8 },
            { label: 'September', value: 9 },
            { label: 'October', value: 10 },
            { label: 'November', value: 11 },
            { label: 'December', value: 12 },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        this.label = this.options[this.value].label;
    }
}