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
    mixin declarationAndProperties!("genericView", "gView");

    /**
     * The main controller which controls the overall window
     */
    mixin declarationAndProperties!("mainController", "controller");

    /**
     * Initializing constructor
     * 
     * @param controller Reference the the main controller
     */
    this(mainController controller, genericView view) {
        this.controller = controller;
        this.gView = view;
    }

    /**
     * Build the view and return the built widget
     */
    Widget getWidget() {
        gView.build();
        return gView.widget;
    }
}
