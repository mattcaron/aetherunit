module controllers.armorController;

import utility.accessorTemplate;

import controllers.subpanelController;
import controllers.mainController;

import views.armorView;

/**
 * Armor controller class
 *
 * Controls the sub-window in which the user enters armor things
 */
class armorController: subpanelController {

    /**
     * The view object that we control
     */
    mixin declarationAndProperties!("armorView", "view");

    /**
     * Initializing constructor
     */
    this(mainController controller) {
        this.view = new armorView(this);
        super(controller, this.view);
    }
}
