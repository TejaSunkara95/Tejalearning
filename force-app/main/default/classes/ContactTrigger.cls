public class ContactTrigger {
    Public static void amountField(list<Contact> contactslist, list<Contact> oldcontactslist, map<id, Contact> oldmap_of_contacts){
        map<id,List<double>> accountid_contact_map;
        if(Trigger.isafter){
            if(Trigger.isinsert){
                accountid_contact_map = accountIdOnContacts(contactsList);
                updateAccount(accountid_contact_map);
            }
            if(Trigger.isupdate){
                accountid_contact_map = accountIdOnContacts_of_Update(contactslist,oldmap_of_contacts);
                updateAccount(accountid_contact_map);
                
            }
            if(Trigger.isdelete){
                accountid_contact_map = accountIdOnContacts(oldContactsList);
                updateAccount_of_Delete(accountid_contact_map);
            }
        }
        
    }
    
    private static map<id,List<double>> accountIdOnContacts(list<contact> contactslist){
        map<id,List<double>> accountid_contact_map =new map<id,List<double>>();
        for(Contact contactref : contactslist){
            if(accountid_contact_map.containsKey(contactref.AccountId)){
                accountid_contact_map.get(contactref.AccountId).add(contactref.Amount__c);
            }
            else{
                List<double> amountlist = new List<double>{contactref.Amount__c};
                    accountid_contact_map.put(contactref.AccountId,amountlist);
            }
        }
        return accountid_contact_map;
    }
    
    private static void updateAccount(map<id,List<double>> accountid_contact_map){
        List<Account> accountslist  = [select id, Total_Amount__c from Account where Id in :accountid_contact_map.keyset()];
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
    
    private static map<id,List<double>> accountIdonContacts_of_Update(list<contact> contactslist,map<id, Contact> oladmap_of_contacts){
        map<id,List<double>> accountid_contact_map =new map<id,List<double>>();
        for(Contact contactref : contactslist){
            Double oldtriggervalue = 0;
            if(oladmap_of_contacts.get(contactref.Id).Amount__c != null){
                oldTriggervalue = oladmap_of_contacts.get(contactref.Id).Amount__c;
            }
            
            double x = 0;
            if(accountid_contact_map.containsKey(contactref.AccountId)){
                x = contactref.Amount__c - oldtriggervalue; 
                accountid_contact_map.get(contactref.AccountId).add(x);
            }
            else{
                x = contactref.Amount__c - oldtriggervalue;
                List<double> d = new List<double>{x};
                    accountid_contact_map.put(contactref.AccountId,d);               
            }
        }
        return accountid_contact_map;
    }
    
    private static void updateAccount_of_Delete(map<id,List<double>> accountid_contact_map){
        List<Account> accountslist  = [select id, Total_Amount__c from Account where Id in :accountid_contact_map.keyset()];
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