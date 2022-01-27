trigger Example1 on Account (before insert,before update) {
    if(Trigger.isinsert || Trigger.isupdate){
        for(Account a : Trigger.new){
            if(a.AnnualRevenue > 1000000){
                a.CustomerPriority__c = 'High';
            }
            else{
                a.CustomerPriority__c = 'Low';
            }
        }
    }
    if(Trigger.isupdate){
        for(Account acc : Trigger.new){
            if(acc.CustomerPriority__c == 'Low'){
                acc.Description = 'Customer priority has been reduced to low';
                
            }
            else if(acc.CustomerPriority__c == 'High'){
                acc.Description = 'Customer priority increased to high';
            }
            
        }
    }
    system.debug(trigger.old[0].CustomerPriority__c);

}