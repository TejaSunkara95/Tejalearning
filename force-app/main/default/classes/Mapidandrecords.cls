public class Mapidandrecords {
    public static void contactIds(){
        List<Account> cts = [select Name from Account];
        map<id,Account> m = new map<id,Account>(cts);
        system.debug(m);
    }

}