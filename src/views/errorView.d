module views.errorView;

import std.stdio;

import gtk.Button;
import gtk.Label;
import gtk.MessageDialog;

import gobject.Type;

import utility.accessorTemplate;

import views.genericView;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string WIDGET_RESOURCE = "errorView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string WIDGET_NAME = "errorDialog";

/**
 * Class to control the error view
 */
class errorView : genericView {

    /**
     * Initializing constructor
     */
    this() {
    }

    /**
     * Popup the dialog window
     *
     * @param message message to display
     *
     * @return true on success
     * @return false on failure
     */
    bool popup(string message) {
        // IMPORTANT: Main.init needs to be called before Builder is
        // created.
        string gladeString = import(WIDGET_RESOURCE);
        bool retVal = true;

        if (!super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME)) {
            retVal = false;
        }
        else {
            Label lblError = cast(Label)builder.getObject("lblError");
            if (lblError is null) {
                writefln("Unable to get label lblError");
                retVal = false;
            }
            else {
                lblError.setText(message);
            }

            Button ok = cast(Button)builder.getObject("btnOK");
            if (ok is null) {
                writefln("Unable to get btnOK");
                retVal = false;
            }
            else {
                ok.addOnClicked(
                    delegate void(Button button) {
                        widget.destroy();
                    }
                );
            }

            if (retVal) {
                widget.showAll();
            }
        }
        return retVal;
    }
}
