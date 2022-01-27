@RestResource(urlMapping = '/RestDemoCreated/*') 
global class RestDemo {
    @HttpGet
    global static Account doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id,
                                 Name, 
                                 Phone,
                                 Website,
                                 ParentId, 
                                 Total_Amount__c FROM Account WHERE Id = :accountId];
        return result;
    }
    
    @HttpPost
    global static string doPost(String name,
        String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;  
    }
    

}