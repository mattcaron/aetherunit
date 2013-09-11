import std.stdio;

import mainController;
import utility.debugPrint;

/**
 * Main function
 */
int main(string[] args) {
    mainController controller = new mainController();
    return controller.go(args);
}
