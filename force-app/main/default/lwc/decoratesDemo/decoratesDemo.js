import { LightningElement,api,track } from 'lwc';

export default class DecoratesDemo extends LightningElement {
 @track
  fullName={          //this is method
    firstName:"please enter firstName",  
    lastName:"please enter lastName"
  }


  handelInputChange(event){
    console.log('handle input is running successfully');
     if(event.target.name=='firstName'){      // if we enter or update value in firstname then this wiill execute
        this.fullName.firstName=event.target.value;  // and put value in fullname
       
     }else if(event.target.name=='lastName'){
        this.fullName.lastName=event.target.value;
       
     }
     console.log('fullName object values are :'+JSON.stringify(this.fullName));
     // here we check the object is running or not if we use object then plese use json.stringify for serialize the object
    }
}