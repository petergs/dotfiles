from pygobject_alert import *

bg_win = BackgroundImageWindow("/tmp/edited_screen.png")
bg_win.connect("destroy", Gtk.main_quit)
bg_win.show_all()

alert_win = AlertDialogWindow(1940, 300)
alert_win.connect("destroy", Gtk.main_quit)
alert_win.show_all()

Gtk.main()
