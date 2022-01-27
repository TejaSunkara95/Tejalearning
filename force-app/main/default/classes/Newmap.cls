public class Newmap {
    
    public static void newmap(){
        map<string,List<string>> a = new map<string,List<string>>();
        List<string> l1 = new List<string>{'dog','cat','lion'};
            List<string> l2 = new List<string>{'crow','pegion','sparrow'};
                List<string> l3 = new List<string>{'mosquito','cockroack','grasshopper'};    
            
        a.put('animal',l1);
		a.put('birds',l2);
		a.put('insects',l3);
        system.debug(a.get('animal'));
		

    }

}