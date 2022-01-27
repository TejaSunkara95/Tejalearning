trigger Amountfield on Contact (after insert,after update, after delete) {
    map<id,List<double>> accountid_contact_map =new map<id,List<double>>();
    list<Contact> contactslist = Trigger.new;
    if(Trigger.isinsert){
        for(Contact contactref : contactslist){
            
            if(accountid_contact_map.containsKey(contactref.AccountId)){
                accountid_contact_map.get(contactref.AccountId).add(contactref.Amount__c);
            }
            else{
                List<double> amountlist = new List<double>{contactref.Amount__c};
                accountid_contact_map.put(contactref.AccountId,amountlist);               
            }
        }
        List<Account> accountslist  = [select id, Total_Amount__c from Account];
        for(Account accountref :accountslist){
            if(accountid_contact_map.containsKey(accountref.Id)){
                if(accountref.Total_Amount__c != null){
                    for(integer i = 0 ;i < accountid_contact_map.get(accountref.Id).size(); i++){
                    accountref.Total_Amount__c = accountref.Total_Amount__c + accountid_contact_map.get(accountref.Id)[i];    
                    }
                }
                else{
                    accountref.Total_Amount__c = 0;
                    for(integer i = 0 ;i < accountid_contact_map.get(accountref.Id).size(); i++){
                    accountref.Total_Amount__c = accountref.Total_Amount__c + accountid_contact_map.get(accountref.Id)[i];
                    }
                }
            }
        }
        Update accountslist;
    }
    if(Trigger.isupdate){
        for(Contact contactref : contactslist){
            Double oldamountvalue = 0;
            if(Trigger.oldmap.get(contactref.Id).Amount__c != null){
                oldamountvalue = Trigger.oldmap.get(contactref.Id).Amount__c ;
            }
           
            double x = 0;
            if(accountid_contact_map.containsKey(contactref.AccountId)){
                x = contactref.Amount__c - oldamountvalue; 
                accountid_contact_map.get(contactref.AccountId).add(x);
            }
            else{
                x = contactref.Amount__c - oldamountvalue;
                List<double> d = new List<double>{x};
                accountid_contact_map.put(contactref.AccountId,d);               
            }
        }
        List<Account> accountslist = [select id, Total_Amount__c from Account];
        for(Account accountref :accountslist){
            if(accountid_contact_map.containsKey(accountref.Id)){
                if(accountref.Total_Amount__c != null){
                    for(integer i = 0 ;i < accountid_contact_map.get(accountref.Id).size(); i++){
                    accountref.Total_Amount__c = accountref.Total_Amount__c + accountid_contact_map.get(accountref.Id)[i];    
                    }
                }
                else{
                    accountref.Total_Amount__c = 0;
                    for(integer i = 0 ;i < accountid_contact_map.get(accountref.Id).size(); i++){
                    accountref.Total_Amount__c = accountref.Total_Amount__c + accountid_contact_map.get(accountref.Id)[i];
                    }
                }
            }
        }
        Update accountslist;
        
    }
    if(Trigger.isdelete){
        for(Contact  contactref: Trigger.old){
            
            if(accountid_contact_map.containsKey(contactref.AccountId)){
                accountid_contact_map.get(contactref.AccountId).add(contactref.Amount__c);
            }
            else{
                List<double> d = new List<double>{contactref.Amount__c};
                accountid_contact_map.put(contactref.AccountId,d);
            }
        }
        List<Account> accountslist  = [select id, Total_Amount__c from Account];
        for(Account accountref :accountslist){
            if(accountid_contact_map.containsKey(accountref.Id)){
                if(accountref.Total_Amount__c != null){
                    for(integer i = 0 ;i < accountid_contact_map.get(accountref.Id).size(); i++){
                    accountref.Total_Amount__c = accountref.Total_Amount__c - accountid_contact_map.get(accountref.Id)[i];    
                    }
                }
                else{
                    accountref.Total_Amount__c = 0;
                    }
                }
            }
        Update accountslist;
        }
}