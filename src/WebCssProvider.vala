/*
 * http://www.gtkforums.com/viewtopic.php?f=3&t=988&start=15
 */

using Gtk;
using GLib;

public class WebCssProvider : Object {

  public static string icons_to_css (int size) {
    StringBuilder css_builder = new StringBuilder();
    Gtk.IconTheme icon_theme = Gtk.IconTheme.get_default ();
    List<string> icon_contexts = icon_theme.list_contexts ();

    // Gtk.Settings settings = Gtk.Settings.get_default ();
    // string icon_sizes_string = settings.gtk_icon_sizes; //TODO
    // print(icon_sizes_string);


    css_builder.append(@".icon$(size){ width:$(size)px; height:$(size)px; }");

    foreach (string context in icon_contexts) {
      // print(context);
      // print("\n");
      List<string> icons = icon_theme.list_icons(context);
      foreach (string icon_name in icons) {
        // print("\t"+icon_name);
        // print("\n");
        Gtk.IconInfo icon_info = icon_theme.lookup_icon(icon_name, size, Gtk.IconLookupFlags.USE_BUILTIN); // http://www.valadoc.org/#!api=gtk+-3.0/Gtk.IconLookupFlags
        // print("\t\t"+icon_info.get_filename());
        // print("\n");
        Gdk.Pixbuf icon_pixbuf = icon_info.load_icon();
        //icon_pixbuf.save("./tmp/"+icon_name, "png");
        uint8[] icon_png_buffer;
        icon_pixbuf.save_to_buffer(out icon_png_buffer, "png");
        string base64png = GLib.Base64.encode(icon_png_buffer);
        css_builder.append(@".$(icon_name).icon$(size) { background-image: url(data:image/png;base64,$(base64png)); }\n");
      }
    }

    return css_builder.str;
  }

  public static string theme_to_less (string name, string? variant) {

    switch (variant) {
      case "dark":
      break;
      case "light":
      break;
      default:
        variant = null;
      break;
    }

    Gtk.Settings settings = Gtk.Settings.get_default ();

    var font = settings.gtk_font_name.split(" ");

    string html_font = "* { font-family: "+font[0]+"; font-size: "+font[1]+"pt; }";

    StringBuilder css_builder = new StringBuilder();

    string old_css = Gtk.CssProvider.get_named(name, variant).to_string();
    
    string new_css;

    var rows = old_css.split("\n");

    css_builder.append(html_font+"\n");

    for (int i=0;i<rows.length;i++) {
      if(rows[i].contains("@define-color")) {
        rows[i] = rows[i].replace("define-color ", "");
        int space = rows[i].index_of(" ");
        rows[i] = rows[i].slice(0,space)+":"+rows[i].slice(space, rows[i].length);
      }

      /*
       * Fix global widget properties
       */
      if(rows[i].contains("* {")) {
        css_builder.append(rows[i]+"\n");
        i++;
        /*all widgets should not have the same background*/
        if(rows[i].contains("background-color:")) {
          css_builder.append("//");
        }
      }

      /* 
       * 
       */
      rows[i] = rows[i].replace("mix (", "mix(");

       /*
        * Modifies passed color's alpha by a factor f. f is a floating point number. f < 1.0 results in a more transparent color while f > 1.0 results in a more opaque color.
        */ 
      rows[i] = rows[i].replace("alpha (", "alpha(");

      /*
       * shade(color, f) - A lighter or darker variant of color, f is a floating point number
       * "f" is the brightness that I described previously,but here it's between 0.0 and 2.0.
       *
       * If you set a color using one of the basic color keywords, say blue,
       * then on the next line use: shade(blue, 1.0) it will not change.
       * But if you set: shade(blue, 0.0) then you'll get black.
       * If you use: shade(blue, 2.0) you'll get white.
       */
      rows[i] = rows[i].replace("shade (", "shade(");

      rows[i] = rows[i].replace("from (", "from(");

      rows[i] = rows[i].replace("color-stop (", "color-stop(");

      rows[i] = rows[i].replace("to (", "to(");

      /*
       * css pseudo-classes
       */

      rows[i] = rows[i].replace(":inconsistent", ".inconsistent");

      rows[i] = rows[i].replace(":backdrop", ".backdrop");

      rows[i] = rows[i].replace(":insensitive", ".insensitive");

      rows[i] = rows[i].replace(":selected", ".selected");

      rows[i] = rows[i].replace(":backdrop", ".backdrop");

      rows[i] = rows[i].replace(":insensitive", ".insensitive");

      rows[i] = rows[i].replace(".check:active", ".check.active");

      rows[i] = rows[i].replace(".radio:active", ".radio.active");
 

      rows[i] = rows[i].replace("Gtk", "gtk");

      rows[i] = rows[i].replace("Arrow", "arrow");

      rows[i] = rows[i].replace("Button", "button");

      rows[i] = rows[i].replace("Check", "check");

      rows[i] = rows[i].replace("Wnck-", "wnck-");

      rows[i] = rows[i].replace("Entry", "entry");

      rows[i] = rows[i].replace("Expander", "expander");

      rows[i] = rows[i].replace("HTML", "html");

      rows[i] = rows[i].replace("IMHtml", "imhtml");

      rows[i] = rows[i].replace("Bar", "bar");

      rows[i] = rows[i].replace("Item", "item");

      rows[i] = rows[i].replace("Menu", "menu");

      rows[i] = rows[i].replace("Notebook", "notebook");

      rows[i] = rows[i].replace("Paned", "paned");

      rows[i] = rows[i].replace("Progress", "progress");

      rows[i] = rows[i].replace("Range", "range");

      rows[i] = rows[i].replace("Scale", "scale");

      rows[i] = rows[i].replace("Scroll", "scroll");

      rows[i] = rows[i].replace("Window", "window");

      rows[i] = rows[i].replace("Separator", "separator");

      rows[i] = rows[i].replace("Status", "status");

      rows[i] = rows[i].replace("Text", "text");

      rows[i] = rows[i].replace("View", "view");

      rows[i] = rows[i].replace("Tool", "tool");

      rows[i] = rows[i].replace("Group", "group");

      rows[i] = rows[i].replace("Tree", "tree");

      rows[i] = rows[i].replace("Widget", "widget");

      rows[i] = rows[i].replace("Tool", "tool");

      rows[i] = rows[i].replace("Group", "group");

      rows[i] = rows[i].replace("Level", "level");

      rows[i] = rows[i].replace("Icon", "icon");

      rows[i] = rows[i].replace("Image", "image");

      rows[i] = rows[i].replace("Wnck", "wnck");

      rows[i] = rows[i].replace("Tasklist", "tasklist");

      rows[i] = rows[i].replace("TerminalScreen", "-terminalscreen");

      rows[i] = rows[i].replace("Panel", "panel");

      rows[i] = rows[i].replace("GdMain", "gdmain");



      rows[i] = rows[i].replace("-gtk-gradient (", "-webkit-gradient(");

      if( rows[i].contains("currentColor") )
        rows[i] = "// "+ rows[i];


      css_builder.append(rows[i]);
      css_builder.append("\n");

    }
    new_css = css_builder.str;
    return new_css;
  }

  public static void save_file(string filename, string content) {
    try{
        FileUtils.set_contents(filename,content);
    }catch(Error e){
        stderr.printf ("Error: %s\n", e.message);
    }
  }
}

int main (string[] args) {

    Gtk.init (ref args);

    string less = WebCssProvider.theme_to_less(args[1], args[2]);
    WebCssProvider.save_file("build/"+args[1]+"_theme.less", less);

    less = WebCssProvider.icons_to_css(24);
    WebCssProvider.save_file(@"result/$(args[1])_icons_24.css", less);
    less = WebCssProvider.icons_to_css(16);
    WebCssProvider.save_file(@"result/$(args[1])_icons_16.css", less);

    return 0;
}