/**
 * @file
 * 
 * mixin template for one-line creation of private variables and
 * accessors for same.
 * 
 * Copyright (C) 2013 Matthew Caron <matt@mattcaron.net>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

/**
 * Mixin to generate declaration and properties.
 * 
 * @param type type of property
 * @param name name of property
 *
 * Call it like:
 * 
 *    mixin declarationAndProperties!("type", "name");
 *
 * as in:
 * 
 *    mixin declarationAndProperties!("int", "someID");
 *    mixin declarationAndProperties!("string", "someName");
 *
 * and, based on the first call, it will emit code like:
 *
 *  private type _name
 *  @property {
 *      type name()
 *      {
 *          return _name;
 *      }
 *      type name(type name)
 *      {
 *          return _name = name;
 *      }
 *  }
 *
 * This can then be accessed like a normal public member (but it
 * isn't), and you can later remove the call to the mixin and implement
 * it normally if more complex logic is required.
 *
 */
mixin template declarationAndProperties(string type, string name)
{
    mixin (
        "private "~type~" _"~name~";
        @property {
            "~type~" "~name~"()
            {
                return _"~name~";
            }

            "~type~" "~name~"("~type~" "~name~")
            {
                return _"~name~" = "~name~";
            }
        }"
    );
}
