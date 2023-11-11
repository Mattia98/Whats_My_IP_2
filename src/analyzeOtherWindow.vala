/* analyzeOtherWindow.vala
 *
 * Copyright 2021 Mattia
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
 */


namespace Whatsmyip2 {
	[GtkTemplate (ui = "/org/mattia98/whatsmyip2/analyzeOther.ui")]
	public class AnalyzeOtherWindow : Gtk.Window {
	    [GtkChild]
		unowned Gtk.Button button_go;
		[GtkChild]
		unowned Gtk.Button button_cancel;
        [GtkChild]
		unowned Gtk.Entry entry_host;

		public signal void go_clicked(string host);

	    public AnalyzeOtherWindow() {
	        button_cancel.clicked.connect(this.cancel);
	        button_go.clicked.connect(this.go);
	        entry_host.activate.connect(this.go);
	    }

	    private void go() {
	        this.close();
            go_clicked(entry_host.text);
	    }

	    private void cancel() {
		    this.close();
		}
	}
}
