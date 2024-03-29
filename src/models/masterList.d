module models.masterList;

import std.conv;
import std.regex;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.basicUnit;
import models.supportUnit;
import models.eliteUnit;
import models.armor;
import models.rangedWeapon;
import models.meleeWeapon;

/**
 * A "master" list class consisting of a bunch of arrays of all the
 * other possible aetherVerseObject subtyptes
 */
class masterList {

    /**
     * List types
     *
     * This is an enumerated type so that we can reference them in a
     * quick and easy fashion. Everything in this list should be
     * replecated in the list below.
     */
    enum listType {
        Unknown, 
        BasicUnit,
        EliteUnit,
        SupportUnit,
        Armor,
        MeleeWeapon,
        RangedWeapon
    }

    /**
     * List of basic units
     */
    mixin declarationAndProperties!("basicUnit[]", "basicUnits");

    /**
     * List of elite units
     */
    mixin declarationAndProperties!("eliteUnit[]", "eliteUnits");

    /**
     * List of support units
     */
    mixin declarationAndProperties!("supportUnit[]", "supportUnits");

    /**
     * List of armors
     */
    mixin declarationAndProperties!("armor[]", "armors");
    
    /**
     * List of ranged weapons
     */
    mixin declarationAndProperties!("rangedWeapon[]", "rangedWeapons");

    /**
     * List of melee weapons
     */
    mixin declarationAndProperties!("meleeWeapon[]", "meleeWeapons");

    /**
     * Default constructor
     */
    this() {
    }

    /**
     * Get the object to which a TreeView coordinates "path" points
     *
     * A TreeView path consists of a series of integer indices (0
     * based) separated by commas. So, 2,4 is the fifth child of the
     * third node. We populate the menu as follows:
     * 
     * - Basic Units
     * - Elite Units
     * - Support Units
     * - Armors
     * - Ranged Weapons
     * - Melee Weapons
     *
     * @param path the path to be decoded
     *
     * @return the aetherVerseObject pointed to by the path, or null
     *         if it's none of those
     */
    aetherVerseObject getObjectFromPath(string path) {
        aetherVerseObject retVal = null;
        int[] indices;
        string[] splitStrings = split(path, regex(r",\D*"));
        foreach (string splitString; splitStrings) {
            indices ~= to!int(splitString);
        }

        if (indices.length > 1) {
            // The top level is the heading, the next level is the
            // index in to it
            switch (indices[0]) {
            case 0:
                retVal = basicUnits[indices[1]];
                break;
            case 1:
                retVal = eliteUnits[indices[1]];
                break;
            case 2:
                retVal = supportUnits[indices[1]];
                break;
            case 3:
                retVal = armors[indices[1]];
                break;
            case 4:
                retVal = rangedWeapons[indices[1]];
                break;
            case 5:
                retVal = meleeWeapons[indices[1]];
                break;
            default:
                // retVal is already null
                break;
            }
        }
        // else, it's == 1 so it's a heading or nothing is selected,
        // just set the add button

        return retVal;
    }

    /**
     * Get the base object type to which a TreeView coordinates "path"
     * points.
     *
     * This presumes that it is pointed at a heading.
     *
     * See above description of how the path works
     *
     * @param path the path to be decoded
     *
     * @return The appropriate listType, or UNKNOWN if we can't figure
     * out what the path points to.
     */
    listType getObjectTypeFromPath(string path) {
        listType retVal = listType.Unknown;
        int[] indices;
        string[] splitStrings = split(path, regex(r",\D*"));
        foreach (string splitString; splitStrings) {
            indices ~= to!int(splitString);
        }
        
        switch (indices[0]) {
        case 0:
            retVal = listType.BasicUnit;
            break;
        case 1:
            retVal = listType.EliteUnit;
            break;
        case 2:
            retVal = listType.SupportUnit;
            break;
        case 3:
            retVal = listType.Armor;
            break;
        case 4:
            retVal = listType.RangedWeapon;
            break;
        case 5:
            retVal = listType.MeleeWeapon;
            break;
        default:
            // retVal is already listType.Unknown
            break;
        }

        return retVal;
    }

}
