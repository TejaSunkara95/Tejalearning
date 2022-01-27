public class Addition {
    public static void oddNumbers(Integer n){
        Double x,y;
        if(math.mod(n, 2) == 0){
            n = n-1;
        }
        x = ((n+1)/2);
        y = math.pow(x, 2);
        system.debug('sum of odd numbers is ' + y);
    }
    public static void evenNumbers(Integer n){
        Integer x;
        if(math.mod(n, 2) != 0){
            n = n-1;
        }
        x = n/2*(n/2+1);
        system.debug('sum of even numbers is'+x);
    }
    public static void multiplicationOf5(Integer n){
        integer x;
        for(integer i = 0 ; i<=n; i++){
            x = 5*i;
            system.debug('5*'+i+'='+x);
        }
    }
    
    

}