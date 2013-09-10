import std.stdio;
import std.c.process;

import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;

import gobject.Type;

int main(string[] args) {
    string gladestring = import("main.glade");
    int retVal = 1;

    Main.init(args);

    Builder g = new Builder();

    if(!g.addFromString(gladestring, gladestring.length)) {
        writefln("Oops, could not create Glade object, "
                 "check your glade file ;)");
    } else {
        Window w = cast(Window)g.getObject("window1");

        if (w !is null) {
            w.addOnHide(
                delegate void(Widget aux) { 
                    retVal = 0;
                    // FIXME - only main should exit
                    exit(retVal);
                }
            );
        } else {
            writefln("No window?");
        }

        w.showAll();
        Main.run();
    }

    return retVal;
}
