import { LightningElement, api } from 'lwc';

export default class Child1 extends LightningElement {
    @api
    count =0;
    @api
    childFunction1(){
        this.count++;
    }
    @api
    childFunction2(){
        this.count--;
    }

}