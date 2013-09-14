import utility.accessorTemplate;

import aetherVerseObject;
import statList;

abstract class unit : aetherVerseObject {

    enum unitType {
        Basic,
        Elite,
        Support
    }

    // Basic array to satisfy compiler.
    immutable int[] baseModelArray = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    immutable int[] extraModelsArray = [ 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3];
    immutable int extraStatPoints = 0;

    mixin declarationAndProperties!("statList", "unitStatDifferential");

    unitType type;

    this(armyProfile profile) {
        super(profile);
    }

    int calculateBaseModels() {
        return baseModelArray[profile.TEK];
    }

    int calculateExtraModels() {
        return extraModelsArray[profile.TEK];
    }

}
