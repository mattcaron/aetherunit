module views.errorView;

import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Widget;
import gtk.MessageDialog;
import gtk.Label;

import gobject.Type;

import utility.accessorTemplate;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string ERROR_WINDOW_RESOURCE = "errorView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string ERROR_WINDOW_NAME = "errorDialog";

/**
 * Class to control the error view
 */
class errorView {

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
        string gladestring = import(ERROR_WINDOW_RESOURCE);
        bool retVal = true;

        Builder g = new Builder();

        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", ERROR_WINDOW_RESOURCE);
            retVal = false;
        } 
        else {
            MessageDialog w = cast(MessageDialog)g.getObject(ERROR_WINDOW_NAME);
            
            if (w is null) {
                writefln("Unable to get handle to error window %s", 
                         ERROR_WINDOW_NAME);
                retVal = false;
            }
            else {
                w.addOnHide(
                    delegate void(Widget aux) { 
                        w.destroy(); 
                    } 
                );
            }

            Label lblError = cast(Label)g.getObject("lblError");
            if (lblError is null) {
                writefln("Unable to get label lblError");
                retVal = false;
            }
            else {
                lblError.setText(message);
            }

            Button ok = cast(Button)g.getObject("btnOK");
            if (ok is null) {
                writefln("Unable to get btnOK");
                retVal = false;
            }
            else {
                ok.addOnClicked(
                    delegate void(Button button) {
                        w.destroy();
                    }
                );
            }

            if (retVal) {
                w.showAll();
            }
        }
        return retVal;
    }
}
