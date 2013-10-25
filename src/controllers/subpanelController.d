module controllers.subpanelController;

import std.stdio;

import gtk.Widget;

import utility.accessorTemplate;

import controllers.genericController;
import controllers.mainController;

import views.genericView;

/**
 * Abstract class to represent a generic controller for the subpanel
 */
abstract class subpanelController: genericController {

    /**
     * The view object that we control
     */
    mixin declarationAndProperties!("genericView", "view");

    /**
     * The main controller which controls the overall window
     */
    mixin declarationAndProperties!("mainController", "controller");

    /**
     * Initializing constructor
     * 
     * @param controller Reference the the main controller
     */
    this(mainController controller) {
        this.controller = controller;
    }

    /**
     * Build the view and return the built widget
     */
    Widget getWidget() {
        view.build();
        return view.widget;
    }
}
