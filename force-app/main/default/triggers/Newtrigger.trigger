trigger Newtrigger on Opportunity (after insert, after update) {
    List<opportunity> opp = trigger.new;
    List<Account> acc = [select id, Closed_Opportunities__c from Account];
    integer value = 0;
    map<id,integer> closedOpportunitiesmap = new map<id,integer>();
    if(Trigger.isafter && (Trigger.isinsert || Trigger.isupdate)){
        for(Opportunity closedOpportunities : opp){
            if(!closedOpportunitiesmap.containsKey(closedOpportunities.AccountId)){
                closedOpportunitiesmap.put(closedOpportunities.AccountId, 0);
            }
            if(closedOpportunities.IsClosed){
                value = closedOpportunitiesmap.get(closedOpportunities.AccountId);
                value = value + 1;
                closedOpportunitiesmap.put(closedOpportunities.AccountId, value);
            }    
        }
        
        for(Account accountRecord : acc){
            if(closedOpportunitiesmap.containsKey(accountRecord.Id)){
                if(accountRecord.Closed_Opportunities__c == null){
                    accountRecord.Closed_Opportunities__c = 0;
                }
                accountRecord.Closed_Opportunities__c =accountRecord.Closed_Opportunities__c + closedOpportunitiesmap.get(accountRecord.Id);
            }
        }
        update acc;
    }
    
}