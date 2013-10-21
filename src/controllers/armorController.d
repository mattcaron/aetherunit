module controllers.armorController;

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
     * Initializing constructor
     */
    this(mainController controller) {
        this.view = new armorView(controller, this);
    }
}
