module models.statList;

import utility.accessorTemplate;

/**
 * A class describing the list of stats on which all units are based.
 */
class statList {

    /**
     * DEX stat
     */
    mixin declarationAndProperties!("int", "DEX");
    /**
     * STR stat
     */
    mixin declarationAndProperties!("int", "STR");
    /**
     * CON stat
     */
    mixin declarationAndProperties!("int", "CON");
    /**
     * TEK stat
     */
    mixin declarationAndProperties!("int", "TEK");
    /**
     * MOR stat
     */
    mixin declarationAndProperties!("int", "MOR");
    /**
     * PRE stat
     */
    mixin declarationAndProperties!("int", "PRE");
}
