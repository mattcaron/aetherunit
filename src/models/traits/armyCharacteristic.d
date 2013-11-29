module models.traits.armyCharacteristic;

import std.conv;
import std.stdio;
import std.traits;

import utility.accessorTemplate;

import models.statList;

import models.traits.aetherVerseTrait;
import models.traits.armyArchaic;
import models.traits.armyBarbaric;

abstract class armyCharacteristic : aetherVerseTrait {

    enum armyCharacteristicList : string {
        Archaic = "Archaic", 
        Barbaric = "Barbaric",
        Bloodthirsty = "Bloodthirsty",
        Chivalrous = "Chivalrous",
        Crusading = "Crusading",
        Experienced = "Experienced",
        Feudal = "Feudal",
        Guerilla = "Guerilla",
        Hardened = "Hardened",
        HiveMind = "Hive Mind", 
        Mechanized = "Mechanized",
        Militant = "Militant",
        Organic = "Organic",
        Political = "Political",
        Puppets = "Puppets",
        Regimented = "Regimented",
        Sorcerous = "Sorcerous",
        Technological = "Technological",
        Technophobes = "Technophobes",
        Terrifying = "Terrifying"
    }

    /**
     * Initializing constructor
     *
     * @param unitStatList the stat list for the army to which this 
     *                     characteristic applies
     */
    this(statList armyStatList) {
        super(armyStatList);
    }

    /**
     * Populate a list of all possible army characteristics
     *
     * @param unitStatList the base unit stat list
     * 
     * @return a populated list of characteristics
     */
    static armyCharacteristic[] populate(statList unitStatList) {
        armyCharacteristic[] characteristics;
        armyCharacteristic newCharacteristic;
        // FIXME - looping through the enum would be nice here, but I
        // can't make it actually work.
        // FIXME - make this a series of mixins
        newCharacteristic = new armyArchaic(unitStatList);
        characteristics ~= newCharacteristic;
        newCharacteristic = new armyBarbaric(unitStatList);
        characteristics ~= newCharacteristic;
        return characteristics;
    }
}
