module views.armorView;

import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Label;
import gtk.Widget;

import gobject.Type;

import utility.accessorTemplate;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string ARMOR_WINDOW_RESOURCE = "armorView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string ARMOR_WINDOW_NAME = "armorDialog";

/**
 * Class to control the armor view
 */
class armorView {

    mixin declarationAndProperties!("Widget", "w");

    /**
     * Initializing constructor
     */
    this() {
    }

    /**
     * Popup the dialog window
     *
     * @return true on success
     * @return false on failure
     */
    bool build() {
        // IMPORTANT: Main.init needs to be called before Builder is
        // created.
        string gladestring = import(ARMOR_WINDOW_RESOURCE);
        bool retVal = true;

        Builder g = new Builder();

        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", ARMOR_WINDOW_RESOURCE);
            retVal = false;
        } 
        else {
            w = cast(Widget)g.getObject(ARMOR_WINDOW_NAME);
            
            if (w is null) {
                writefln("Unable to get handle to error window %s", 
                         ARMOR_WINDOW_NAME);
                retVal = false;
            }
        }
        return retVal;
    }
}
