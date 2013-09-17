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
    immutable int MINIMUM_ATTRIBUTE_VALUE = 0;
    immutable int MAXIMUM_ATTRIBUTE_VALUE = 10;

    mixin declarationAndProperties!("statList", "armyStats");
    mixin declarationAndProperties!("int", "armyBaseCost");
    mixin statListProperties!("DEX");
    mixin statListProperties!("STR");
    mixin statListProperties!("CON");
    mixin statListProperties!("TEK");
    mixin statListProperties!("MOR");
    mixin statListProperties!("PRE");

    private int summation(int x) {
        int temp = 0;
        foreach (int i; 0..x+1) {
            temp += i;
        }
        return temp;
    }

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

    bool attributeValueInRange(int newValue) {
        bool retVal = false;
        if (newValue >= MINIMUM_ATTRIBUTE_VALUE &&
            newValue <= MAXIMUM_ATTRIBUTE_VALUE) {
            retVal = true;
        }
        return retVal;
    }

}
