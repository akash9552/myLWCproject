import { LightningElement } from 'lwc';

export default class TestOne extends LightningElement {
    message ='This is a test lwc component';
    Name = '';

    handleClick(){
        console.log('This handle click method run msg');
    }
    displyName(){
        this.Name='Akash';
    }
}