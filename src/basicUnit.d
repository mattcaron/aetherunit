import armyProfile;
import unit;

class basicUnit : unit {

    immutable int[] baseModelArray = [20, 20, 16, 12, 10, 8, 6, 5, 5, 3, 3];

    this(armyProfile profile) {
        super(profile);
        type = unitType.Basic;
    }
}
