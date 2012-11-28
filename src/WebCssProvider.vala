/*
 * http://www.gtkforums.com/viewtopic.php?f=3&t=988&start=15
 */

using Gtk;

public class WebCssProvider : Object {

  public static string to_lesscss (string name, string? variant) {

    switch (variant) {
      case "dark":
      break;
      case "light":
      break;
      default:
        variant = null;
      break;
    }

    StringBuilder css_builder = new StringBuilder();

    string old_css = Gtk.CssProvider.get_named(name, variant).to_string();
    
    string new_css;

    var rows = old_css.split("\n");

    for (int i=0;i<rows.length;i++) {
      if(rows[i].contains("@define-color")) {
        rows[i] = rows[i].replace("define-color ", "");
        int space = rows[i].index_of(" ");
        rows[i] = rows[i].slice(0,space)+":"+rows[i].slice(space, rows[i].length);
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
}

int main (string[] args) {

    Gtk.init (ref args);

    string new_css = WebCssProvider.to_lesscss(args[1], args[2]);
    print(new_css);

    return 0;
}