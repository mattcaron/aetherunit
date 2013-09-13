import utility.accessorTemplate;
import utility.debugPrint;

class armyProfile {

    private int summation(int x) {
        int temp = 0;
        foreach (int i; 0..x+1) {
            temp += i;
        }
        return temp;
    }

    mixin declarationAndProperties!("int", "DEX");
    mixin declarationAndProperties!("int", "STR");
    mixin declarationAndProperties!("int", "CON");
    mixin declarationAndProperties!("int", "TEK");
    mixin declarationAndProperties!("int", "MOR");
    mixin declarationAndProperties!("int", "PRE");
    mixin declarationAndProperties!("int", "armyBaseCost");

    int recalculate() {
        armyBaseCost = summation(DEX) + summation(STR) + summation(CON) + 
                       summation(TEK) + summation(MOR) + summation(PRE);
        return armyBaseCost;
    }

}
