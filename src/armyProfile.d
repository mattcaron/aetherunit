import utility.accessorTemplate;
import utility.debugPrint;

import statList;


mixin template statListProperties(string name)
{
    mixin (
        "@property {
            int "~name~"()
            {
                return armyStats."~name~";
            }

            int "~name~"(int "~name~")
            {
                return armyStats."~name~" = "~name~";
            }
        }"
    );
}

class armyProfile {

    immutable int MINIMUM_ARMY_COST = 50;

    private int summation(int x) {
        int temp = 0;
        foreach (int i; 0..x+1) {
            temp += i;
        }
        return temp;
    }

    mixin declarationAndProperties!("statList", "armyStats");
    mixin declarationAndProperties!("int", "armyBaseCost");
    mixin statListProperties!("DEX");
    mixin statListProperties!("STR");
    mixin statListProperties!("CON");
    mixin statListProperties!("TEK");
    mixin statListProperties!("MOR");
    mixin statListProperties!("PRE");

    this() {
        armyStats = new statList();
    }

    int recalculate() {
        armyBaseCost = summation(DEX) + summation(STR) + summation(CON) + 
                       summation(TEK) + summation(MOR) + summation(PRE);
        if (armyBaseCost < MINIMUM_ARMY_COST) {
            armyBaseCost = MINIMUM_ARMY_COST;
        }
        return armyBaseCost;
    }

}
