module models.armyProfile;

import utility.accessorTemplate;

import models.statList;

/**
 * Template to make an accessor for a property contained in the
 * armyStats statList
 */
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

/**
 * This class stores and validates the base profile for an army
 */
class armyProfile {

    /**
     * The minimum army cost
     */
    immutable int MINIMUM_ARMY_COST = 50;

    /**
     * The minimum attribute value
     */
    immutable int MINIMUM_ATTRIBUTE_VALUE = 0;

    /**
     * The maximum attribute value
     */
    immutable int MAXIMUM_ATTRIBUTE_VALUE = 10;

    /**
     * Base army stat list
     */
    mixin declarationAndProperties!("statList", "armyStats");

    /**
     * Base army cost
     *
     * This is calculated based on armyStats, and is saved here so we
     * don't have to recalculate it each time we need it.
     */
    mixin declarationAndProperties!("int", "armyBaseCost");

    /**
     * Accessor to expose armyStats.DEX to users of this class
     */
    mixin statListProperties!("DEX");

    /**
     * Accessor to expose armyStats.STR to users of this class
     */
    mixin statListProperties!("STR");

    /**
     * Accessor to expose armyStats.CON to users of this class
     */
    mixin statListProperties!("CON");

    /**
     * Accessor to expose armyStats.TEK to users of this class
     */
    mixin statListProperties!("TEK");

    /**
     * Accessor to expose armyStats.MOR to users of this class
     */
    mixin statListProperties!("MOR");

    /**
     * Accessor to expose armyStats.PRE to users of this class
     */
    mixin statListProperties!("PRE");

    /**
     * Utility function to provide a summation function
     *
     * @param x integer of which to get a summation
     *
     * @return the summation of x
     */
    private int summation(int x) {
        int temp = 0;
        foreach (int i; 0..x+1) {
            temp += i;
        }
        return temp;
    }

    /**
     * Default constructor
     */
    this() {
        armyStats = new statList();
    }

    /**
     * Recalculate anything which needs to be recalculated and save it
     * away
     *
     * @FIXME - why return this?
     *
     * @return the army base cost. 
     */
    int recalculate() {
        armyBaseCost = summation(DEX) + summation(STR) + summation(CON) + 
                       summation(TEK) + summation(MOR) + summation(PRE);
        if (armyBaseCost < MINIMUM_ARMY_COST) {
            armyBaseCost = MINIMUM_ARMY_COST;
        }
        return armyBaseCost;
    }

    /**
     * Verify that a new attribue value within the valid range.
     *
     * @param newValue value to check if it's in range.
     *
     * @return true if it is in range
     * @return false if it is not
     */
    bool attributeValueInRange(int newValue) {
        bool retVal = false;
        if (newValue >= MINIMUM_ATTRIBUTE_VALUE &&
            newValue <= MAXIMUM_ATTRIBUTE_VALUE) {
            retVal = true;
        }
        return retVal;
    }

}
