/* settingsWindow.vala
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
	[GtkTemplate (ui = "/org/mattia98/whatsmyip2/settings.ui")]
	public class SettingsWindow : Gtk.Window {
        [GtkChild]
		unowned Gtk.Button button_cancel;
		[GtkChild]
		unowned Gtk.Button button_save;
        [GtkChild]
		unowned Gtk.Entry entry_host_ping;

		public SettingsWindow() {
			//GLib.Object (application: app);
		    Settings settings = Settings.getInstance();

            button_cancel.clicked.connect(this.cancel);
            button_save.clicked.connect(this.save);
            entry_host_ping.text = settings.host_ping;
		}

		private void save() {
		    Settings settings = Settings.getInstance();
		    stdout.printf("This is the text: %s \n", entry_host_ping.text);
		    settings.host_ping = entry_host_ping.text;
		    this.close();
		}

		private void cancel() {
		    this.close();
		}

	}
}
