module models.traits.armorTrait;

import std.conv;
import std.stdio;
import std.traits;

import utility.accessorTemplate;

import models.statList;

import models.traits.aetherVerseTrait;
import models.traits.armorPoweredArmor;
import models.traits.armorStabilizationArmor;

abstract class armorTrait : aetherVerseTrait {

    enum armorTraitList : string {
        PoweredArmor = "Powered Armor",
        StabilizationArmor = "Stabilization Armor",
        TacticalBattleArmor = "Tactical Battle Armor",
        SupportBattleArmor = "Support Battle Armor",
        ReinforcedExoskeletonAssaultArmor = 
                "Reinforced Exoskeleton Assault Armor", 
        AdvancedBattlesuitSystem = "Advanced Battlesuit System",
        BattlesuitShielding = "Battlesuit Shielding",
        EnergyShielded = "Energy Shielded",
        MasterworkArmor = "Masterwork Armor",
        Psyarmor = "Psyarmor",
        StealthArmor = "Stealth Armor"
    }

    /**
     * Initializing constructor
     *
     * @param unitStatList the stat list for the unit to which this 
     */
    this(statList unitStatList) {
        super(unitStatList);
    }

    /**
     * Populate a list of all possible armor traits
     *
     * @param unitStatList the base unit stat list
     * 
     * @return a populated list of traits
     */
    static armorTrait[] populate(statList unitStatList) {
        armorTrait[] traits;
        armorTrait newTrait;
        newTrait = new armorPoweredArmor(unitStatList);
        traits ~= newTrait;
        newTrait = new armorStabilizationArmor(unitStatList);
        traits ~= newTrait;
        return traits;
    }
}
