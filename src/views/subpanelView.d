module views.subpanelView;

import std.stdio;

import utility.accessorTemplate;

import controllers.mainController;
import controllers.subpanelController;

import views.genericView;

/**
 * Abstract class to control a sub panel view
 */
abstract class subpanelView: genericView {

    /**
     * Reference to our sub panel controller
     *
     * This is used to inform our controller of updates
     */
    mixin declarationAndProperties!("subpanelController", "subController");

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     *
     * @param subController the subpanel controller to which callbacks
     * should be directed.
     */
    this(mainController controller, subpanelController subController) {
        super(controller);
        this.subController = subController;
    }
}
