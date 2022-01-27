public class Example2 {
    public static void example(){
        
        
            
            List<Account> a = [select Name from Account];
        system.debug(a);
        for(Account d : a){
    		
    		system.debug(d.Name);
            
		}
    }

}