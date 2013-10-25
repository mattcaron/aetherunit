module controllers.addController;

import gtk.Widget;

import controllers.subpanelController;
import controllers.mainController;

import views.addView;

import utility.accessorTemplate;

/**
 * Add controller class
 *
 * Controls the sub-window in which the user clicks "add"
 */
class addController: subpanelController {

    /**
     * Initializing constructor
     */
    this(mainController controller) {
        this.view = new addView(this);
        super(controller);
    }

    /**
     * Function to respond to the generic "Add" button being clicked
     */
    void onAddClicked() {
        controller.onAddClicked();
    }
}
