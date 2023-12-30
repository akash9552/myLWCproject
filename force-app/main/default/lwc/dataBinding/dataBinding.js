import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {

    FirstName ='';
    LastName ='';

    handleChange(event){

        const field = event.target.value;

        if(field === 'fname'){
            this.FirstName = event.target.value;
        }else if(field === 'lname'){
            this.LastName = event.target.value;
        }
    }
    get uppercasedfullname(){
        return `${this.FirstName}  ${this.LastName}`.toUpperCase();
    }
}