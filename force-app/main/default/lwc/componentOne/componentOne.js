import { LightningElement } from 'lwc';

export default class ComponentOne extends LightningElement {

    age;
    eligible = false;
    notEligible = false;

handleInput(event){
        this.age = event.target.value;
        if(this.age == ''){
            this.eligible = false;
            this.notEligible = false;
        }
        else if(this.age >= 18 && this.age <100){
            this.eligible = true;
            this.notEligible = false;
        }else if(this.age < 18 && this.age >0 ){
            this.eligible = false;
            this.notEligible = true;
        }else{
            this.eligible = false;
            this.notEligible = false;
        }
    
    
    }
    
}