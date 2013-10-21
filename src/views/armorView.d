module views.armorView;

import std.stdio;

import controllers.armorController;
import controllers.mainController;


import views.subpanelView;
/**
 * Constant string which is the name of our UI description file.
 */
immutable string WIDGET_RESOURCE = "armorView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string WIDGET_NAME = "armorDialog";

/**
 * Class to control the armor view
 */
class armorView : subpanelView {

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     *
     * @param subController the subpanel controller to which callbacks
     * should be directed.
     *
     */
    this(mainController controller, armorController subController) {
        super(controller, subController);
    }

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    override bool build() {
        string gladeString = import(WIDGET_RESOURCE);
        return super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME);
    }
}
