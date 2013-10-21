module controllers.subpanelController;

import std.stdio;

import gtk.Widget;

import utility.accessorTemplate;

import controllers.genericController;

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
     * Build the view and return the built widget
     */
    Widget getWidget() {
        view.build();
        return view.widget;
    }
}
