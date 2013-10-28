module controllers.armorController;

import utility.accessorTemplate;

import controllers.subpanelController;
import controllers.mainController;

import models.armor;

import views.armorView;

/**
 * Armor controller class
 *
 * Controls the sub-window in which the user enters armor things
 */
class armorController : subpanelController {

    /**
     * The view object that we control
     */
    mixin declarationAndProperties!("armorView", "view");

    /**
     * The piece of armor currently described by this controller
     */
    mixin declarationAndProperties!("armor", "currentArmor");

    /**
     * Initializing constructor
     */
    this(mainController controller) {
        this.view = new armorView(this);
        super(controller, this.view);
        this.currentArmor = new armor(controller.profile);
        this.view.lsTraitPopulate(currentArmor.traits);
    }
}
