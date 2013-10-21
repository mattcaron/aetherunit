module models.armorTrait;

import std.traits;

import utility.accessorTemplate;

import models.statList;
import models.aetherVerseTrait;

abstract class armorTrait : aetherVerseTrait {

    enum armorTraitList {
        PoweredArmor,
        StabilizationArmor,
        TacticalBattleArmor,
        SupportBattleArmor,
        ReinforcedExoskeletonAssaultArmor,
        AdvancedBattlesuitSystem,
        BattlesuitShielding,
        EnergyShielded,
        MasterworkArmor,
        Psyarmor,
        StealthArmor
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
     * Wipe an array of traits and populate it with all the armor traits
     *
     * @param traits list of traits to populate
     */
    static void populate(armorTrait[] traits) {
        traits.clear();
        foreach (armorListTrait thisTrait; EnumMembers!armorTraitList) {
            traits ~= cast(armorTrait) (
                armorTrait.factory("models.armor" ~ thisTrait));
        }
    }
}
