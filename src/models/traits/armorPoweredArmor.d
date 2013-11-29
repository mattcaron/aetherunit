module models.traits.armorPoweredArmor;

import utility.accessorTemplate;

import models.statList;

import models.traits.armorTrait;

class armorPoweredArmor : armorTrait {
    
    /**
     * Initializing constructor
     *
     * @param unitStatList the stat list for the unit to which this 
     *                     trait applies.
     */
    this(statList unitStatList) {
        super(unitStatList);
        this.invalidationList = [ 
            armorTraitList.StabilizationArmor,
            armorTraitList.TacticalBattleArmor,
            armorTraitList.SupportBattleArmor,
            armorTraitList.ReinforcedExoskeletonAssaultArmor,
            armorTraitList.AdvancedBattlesuitSystem,
            armorTraitList.BattlesuitShielding,
            armorTraitList.EnergyShielded,
            armorTraitList.Psyarmor,
            armorTraitList.StealthArmor];

        this.name = armorTraitList.PoweredArmor;
    }

    /**
     * Calculate the cost of this object
     *
     * @return the cost of this object
     */
    override int calculate() {
        return 10;
    }

    /**
     * Validate that this object can be used in the current context.
     *
     * @return true if validation passed
     * @return false if failed
     */
    override bool validate() {
        return true;
    }
}
