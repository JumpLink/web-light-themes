using Gtk;
using Gee;

enum foo{
  PARSING_ERROR,
  LAST_SIGNAL
}

public class CssProvider : Gtk.CssProvider {

  struct _PropertyValue {
    Gtk.CssStyleProperty property;
    Gtk.CssValue         value;
    Gtk.CssSection       section;
  }

  struct WidgetPropertyValue {
    string name;
    string value;

    Gtk.CssSection section;
  }

  struct CssRuleset
  {
    Gtk.CssSelector selector;
    WidgetPropertyValue widget_style;
    PropertyValue styles;
    Gtk.Bitmask set_styles;
    uint n_styles;
    uint owns_styles = 1;
    uint owns_widget_style = 1;
  }

  struct CssScanner
  {
    Gtk.CssProvider provider;
    Gtk.CssParser parser;
    Gtk.CssSection section;
    Gtk.CssScanner parent;
    GSList state;
  }

  struct CssProviderPrivate
  {
    GScanner scanner;

    GHashTable symbolic_colors;
    GHashTable keyframes;

    GArray rulesets;
    GResource resource;
  }

  static bool gtk_keep_css_sections = false;
  WidgetPropertyValue widget_property_value[];

  public CssProvider () {
    if ( GLib.Environment.get_variable("GTK_CSS_DEBUG") != null)
        gtk_keep_css_sections = true;
  }

  public new static CssProvider get_named (string name, string? variant) {
      
    return (CssProvider) Gtk.CssProvider.get_named(name, variant);
  }
}


int main (string[] args) {
    Gtk.init (ref args);

    // var window = new Window ();
    // window.title = "First GTK+ Program";
    // window.border_width = 10;
    // window.window_position = WindowPosition.CENTER;
    // window.set_default_size (350, 70);
    // window.destroy.connect (Gtk.main_quit);

    // var button = new Button.with_label ("Click me!");
    // button.clicked.connect (() => {
    //     button.label = "Thank you";
    // });

    // window.add (button);
    // window.show_all ();

    CssProvider prov = CssProvider.get_named("Ambiance", null);
    print(prov.to_string());

    //StyleProperties prop = prov.get_style(button.get_path());
    
    // GLib.ParamSpec[] props = button.list_style_properties();
    // for (int i=0; i<props.length; i++) {
    //     Value val = Value(props[i].value_type);
    //     //print(props[i].name+" "+props[i].get_nick()+" "+props[i].get_blurb()+"\n");

    //     button.style_get_property (props[i].name, ref val);
    //     print(props[i].name+"\t\t\t"+val.strdup_contents()+"\n");
    // }

    // Gtk.ThemingEngine unico = ThemingEngine.load("unico");
    // print(unico.name);
    // Value val = unico.get_style_property ("arrow-texture");
    // print(val.strdup_contents());


    Gtk.main ();
    return 0;
}