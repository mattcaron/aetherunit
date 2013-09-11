/**
 * @file
 * 
 * General debugging routines
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

import std.stdio;

/**
 * Debug print wrapper for writefln.
 *
 * Prints filename, line number, then whatever else you put in, but
 * only if debug is compiled in.
 */
public static void debugPrint(string file = __FILE__,
                              int line = __LINE__, T...)(T args)
{
    debug(1)
    {
        writef("%s:%d ", file, line);
        writefln(args);
    }
}
