import { api, LightningElement } from 'lwc';

export default class Child extends LightningElement {

    uppercaseItemName='defoult value';

    @api
    get itemName(){
        return this.uppercaseItemName;
    }
    set itemName(value){
        this.uppercaseItemName=value.toUpperCase();
    }
}