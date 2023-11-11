/* window.vala
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
using Soup;
using Json;

namespace Whatsmyip2 {
	[GtkTemplate (ui = "/org/mattia98/whatsmyip2/window.ui")]
	public class Window : Gtk.ApplicationWindow {
	    [GtkChild]
		unowned Gtk.Label label_title;
		[GtkChild]
		unowned Gtk.Label label_ip;
		[GtkChild]
		unowned Gtk.Label label_ping;
		[GtkChild]
		unowned Gtk.Label label_flag;
		[GtkChild]
		unowned Gtk.Label label_isp;
		[GtkChild]
		unowned Gtk.Label label_location;
		[GtkChild]
		unowned Gtk.Button button_go;
		[GtkChild]
		unowned Gtk.Button button_analyze_other;
		[GtkChild]
		unowned Gtk.Button button_settings;



		public Window (Gtk.Application app) {
			GLib.Object (application: app);

            button_settings.clicked.connect(this.open_settings);
            button_analyze_other.clicked.connect(this.open_analyze_other);
			button_go.clicked.connect(this.go);
		}

		private void open_settings() {
            var s = new SettingsWindow();
            s.present();
		}

		private void open_analyze_other() {
            var s = new AnalyzeOtherWindow();
            s.go_clicked.connect(this.analyzeOtherGo);
            s.present();
		}

		private void analyzeOtherGo(string host) {
		    string data = getIpData(host);

			string ping;
			Process.spawn_command_line_sync("sh -c \"ping -w 2 -c 1 "+host+" | cut -d '/' -s -f5\"", out ping);
			ping = double.parse(ping).format(new char[double.DTOSTR_BUF_SIZE], "%.2f");

			var parser = new Json.Parser();
            parser.load_from_data(data);
            var root_object = parser.get_root().get_object();

            label_title.label = host;
			label_ip.label = root_object.get_string_member("query");
			label_ping.label = ping+" ms";
			label_isp.label = root_object.get_string_member("isp");
			label_flag.label = convertCCtoEmoji(root_object.get_string_member("countryCode"));
			label_location.label = root_object.get_string_member("city")+" | "+root_object.get_string_member("regionName");
		}

		private void go() {
			string data = getIpData();
			Settings settings = Settings.getInstance();

			string ping;
			Process.spawn_command_line_sync("sh -c \"ping -c 1 "+settings.host_ping+" | cut -d '/' -s -f5\"", out ping);
			ping = double.parse(ping).format(new char[double.DTOSTR_BUF_SIZE], "%.2f");

			var parser = new Json.Parser();
            parser.load_from_data(data);
            var root_object = parser.get_root().get_object();

			label_ip.label = root_object.get_string_member("query");
			label_ping.label = ping+" ms";
			label_isp.label = root_object.get_string_member("isp");
			label_flag.label = convertCCtoEmoji(root_object.get_string_member("countryCode"));
			label_location.label = root_object.get_string_member("city")+" | "+root_object.get_string_member("regionName");
		}

		private string getIpData(string host = "") {
		    string url = "http://ip-api.com/json/"+host;

		    var session = new Soup.Session();
		    var message = new Soup.Message("GET", url);
		    session.send_message(message);
		    return (string) message.response_body.data;
		}

		private string convertCCtoEmoji(string countryCode) {
            unichar first = 127397+countryCode.get_char(0);
            unichar second = 127397+countryCode.get_char(1);

            return first.to_string()+second.to_string();
        }

	}
}
