public class Example1 {
   
    public static void newmap(string key, string value){
         map<string,List<string>> a = new map<string,List<string>>();
        List<string> l1 = new List<string>{'dog','cat','lion'};
            List<string> l2 = new List<string>{'crow','pegion','sparrow'};
                List<string> l3 = new List<string>{'mosquito','cockroack','grasshopper'};    
            
        a.put('animal',l1);
		a.put('birds',l2);
		a.put('insects',l3);
        
        if(a.containskey(key)){
            a.get(key).add(value);
        }
        else{
            List<string> v = new List<string>{value};
                a.put(key,v);
        }
        
        system.debug(a);
        
    }

}