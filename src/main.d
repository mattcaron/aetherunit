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

    Main.init(args);

    Builder g = new Builder();

    if(!g.addFromString(gladestring, gladestring.length)) {
        writefln("Oops, could not create Glade object, "
                 "check your glade file ;)");
        exit(1);
    }

    Window w = cast(Window)g.getObject("window1");

    if (w !is null) {
        w.setTitle("This is a glade window");
        w.addOnHide( delegate void(Widget aux){ exit(0); } );

        Button b = cast(Button)g.getObject("button1");
        if(b !is null) {
            b.addOnClicked(
                delegate void(Button aux){ 
                    exit(0);
                } 
            );
        }
    } else {
        writefln("No window?");
        exit(1);
    }

    w.showAll();
    Main.run();

    return 0;
}
