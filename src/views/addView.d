module views.addView;

import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Label;
import gtk.Widget;

import gobject.Type;

import controllers.mainController;

import utility.accessorTemplate;

import views.genericView;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string WIDGET_RESOURCE = "addView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string WIDGET_NAME = "addDialog";

/**
 * Class to control the armor view
 */
class addView : genericView {

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     */
    this(mainController controller) {
        super(controller);
    }

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    override bool build() {
        string gladeString = import(WIDGET_RESOURCE);
        bool retVal = true;

        if (!super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME)) {
            retVal = false;
        }
        else {
            Button buttonAdd = cast(Button)builder.getObject("buttonAdd");
            if (buttonAdd is null) {
                writefln("Unable to get button: buttonAdd");
            }
            else {
                buttonAdd.addOnClicked(
                    delegate void (Button button) {
                        controller.onAddClicked();
                    }
                );
            }
        }
        return retVal;
    }
}