import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

class BackgroundImageWindow(Gtk.Window):
    def __init__(self, image):

        # get primary monitor resolution
        display = Gdk.Display().get_default()
        monitor = display.get_primary_monitor()
        geo = Gdk.Monitor.get_geometry(monitor)
        (width, height) = (geo.width, geo.height)

        # initiliaze window - set default width/height to maximized
        Gtk.Window.__init__(self, title="Image Background", default_width=width, default_height=height)
        
        # set Gtk.Window object to full screen
        # bspwm seems to be denying this request when a Gtk.Layout object added
        self.fullscreen()

        # initialize Gtk.Layout and add to the window
        self.layout = Gtk.Layout()
        self.layout.set_size(1920, 1080)
        self.add(self.layout)

        # initialize Gtk.Image and put it at 0, 0
        self.bg_image = Gtk.Image(file=image)
        self.layout.put(self.bg_image, 0, 0)

class AlertDialogWindow(Gtk.Window):
    def __init__(self, width, height):
        Gtk.Window.__init__(self, title="Battery Low", default_width=width, default_height=height)
        self.set_type_hint(Gdk.WindowTypeHint.DIALOG)

        self.vert = Gtk.VBox()
        self.add(self.vert)

        self.label = Gtk.Label(label="Battery Low")
        self.vert.add(self.label)

        self.button2 = Gtk.Button(label="Battery Hight")
        self.vert.add(self.button2)
        self.button2.connect("clicked", Gtk.main_quit)
