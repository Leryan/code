
// This file has been generated by the GUI designer. Do not modify.

public partial class MainWindow
{
	private global::Gtk.Fixed cntFixed;
	private global::Gtk.ScrolledWindow GtkScrolledWindow;
	private global::Gtk.TextView txtViewText;
	private global::Gtk.Entry entry1;
	private global::Gtk.Label lblSymbol;
	private global::Gtk.Entry txtStart;
	private global::Gtk.ScrolledWindow GtkScrolledWindow1;
	private global::Gtk.TextView textview1;
	private global::Gtk.Entry txtBy;
	private global::Gtk.Label label1;
	private global::Gtk.Label label2;
	private global::Gtk.Label label3;
	private global::Gtk.Entry txtTo;
	private global::Gtk.Button cmdReplace;
	
	protected virtual void Build ()
	{
		global::Stetic.Gui.Initialize (this);
		// Widget MainWindow
		this.Name = "MainWindow";
		this.Title = global::Mono.Unix.Catalog.GetString ("MainWindow");
		this.WindowPosition = ((global::Gtk.WindowPosition)(4));
		this.Resizable = false;
		this.AllowShrink = true;
		// Container child MainWindow.Gtk.Container+ContainerChild
		this.cntFixed = new global::Gtk.Fixed ();
		this.cntFixed.Name = "cntFixed";
		this.cntFixed.HasWindow = false;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.GtkScrolledWindow = new global::Gtk.ScrolledWindow ();
		this.GtkScrolledWindow.WidthRequest = 525;
		this.GtkScrolledWindow.HeightRequest = 321;
		this.GtkScrolledWindow.Name = "GtkScrolledWindow";
		this.GtkScrolledWindow.ShadowType = ((global::Gtk.ShadowType)(1));
		// Container child GtkScrolledWindow.Gtk.Container+ContainerChild
		this.txtViewText = new global::Gtk.TextView ();
		this.txtViewText.Buffer.Text = "Bon@@jour\n";
		this.txtViewText.CanFocus = true;
		this.txtViewText.Name = "txtViewText";
		this.GtkScrolledWindow.Add (this.txtViewText);
		this.cntFixed.Add (this.GtkScrolledWindow);
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.entry1 = new global::Gtk.Entry ();
		this.entry1.CanFocus = true;
		this.entry1.Name = "entry1";
		this.entry1.Text = global::Mono.Unix.Catalog.GetString ("@@");
		this.entry1.IsEditable = true;
		this.entry1.InvisibleChar = '●';
		this.cntFixed.Add (this.entry1);
		global::Gtk.Fixed.FixedChild w3 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.entry1]));
		w3.X = 540;
		w3.Y = 19;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.lblSymbol = new global::Gtk.Label ();
		this.lblSymbol.Name = "lblSymbol";
		this.lblSymbol.LabelProp = global::Mono.Unix.Catalog.GetString ("Symbol to replace");
		this.cntFixed.Add (this.lblSymbol);
		global::Gtk.Fixed.FixedChild w4 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.lblSymbol]));
		w4.X = 540;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.txtStart = new global::Gtk.Entry ();
		this.txtStart.WidthRequest = 25;
		this.txtStart.CanFocus = true;
		this.txtStart.Name = "txtStart";
		this.txtStart.Text = global::Mono.Unix.Catalog.GetString ("1");
		this.txtStart.IsEditable = true;
		this.txtStart.InvisibleChar = '●';
		this.cntFixed.Add (this.txtStart);
		global::Gtk.Fixed.FixedChild w5 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.txtStart]));
		w5.X = 568;
		w5.Y = 67;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.GtkScrolledWindow1 = new global::Gtk.ScrolledWindow ();
		this.GtkScrolledWindow1.WidthRequest = 523;
		this.GtkScrolledWindow1.HeightRequest = 114;
		this.GtkScrolledWindow1.Name = "GtkScrolledWindow1";
		this.GtkScrolledWindow1.ShadowType = ((global::Gtk.ShadowType)(1));
		// Container child GtkScrolledWindow1.Gtk.Container+ContainerChild
		this.textview1 = new global::Gtk.TextView ();
		this.textview1.CanFocus = true;
		this.textview1.Name = "textview1";
		this.GtkScrolledWindow1.Add (this.textview1);
		this.cntFixed.Add (this.GtkScrolledWindow1);
		global::Gtk.Fixed.FixedChild w7 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.GtkScrolledWindow1]));
		w7.Y = 326;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.txtBy = new global::Gtk.Entry ();
		this.txtBy.WidthRequest = 25;
		this.txtBy.CanFocus = true;
		this.txtBy.Name = "txtBy";
		this.txtBy.Text = global::Mono.Unix.Catalog.GetString ("1");
		this.txtBy.IsEditable = true;
		this.txtBy.InvisibleChar = '●';
		this.cntFixed.Add (this.txtBy);
		global::Gtk.Fixed.FixedChild w8 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.txtBy]));
		w8.X = 636;
		w8.Y = 67;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.label1 = new global::Gtk.Label ();
		this.label1.Name = "label1";
		this.label1.LabelProp = global::Mono.Unix.Catalog.GetString ("Start");
		this.cntFixed.Add (this.label1);
		global::Gtk.Fixed.FixedChild w9 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.label1]));
		w9.X = 540;
		w9.Y = 71;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.label2 = new global::Gtk.Label ();
		this.label2.Name = "label2";
		this.label2.LabelProp = global::Mono.Unix.Catalog.GetString ("inc. by");
		this.cntFixed.Add (this.label2);
		global::Gtk.Fixed.FixedChild w10 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.label2]));
		w10.X = 596;
		w10.Y = 71;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.label3 = new global::Gtk.Label ();
		this.label3.Name = "label3";
		this.label3.LabelProp = global::Mono.Unix.Catalog.GetString ("to");
		this.cntFixed.Add (this.label3);
		global::Gtk.Fixed.FixedChild w11 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.label3]));
		w11.X = 664;
		w11.Y = 71;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.txtTo = new global::Gtk.Entry ();
		this.txtTo.WidthRequest = 25;
		this.txtTo.CanFocus = true;
		this.txtTo.Name = "txtTo";
		this.txtTo.Text = global::Mono.Unix.Catalog.GetString ("8");
		this.txtTo.IsEditable = true;
		this.txtTo.InvisibleChar = '●';
		this.cntFixed.Add (this.txtTo);
		global::Gtk.Fixed.FixedChild w12 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.txtTo]));
		w12.X = 680;
		w12.Y = 67;
		// Container child cntFixed.Gtk.Fixed+FixedChild
		this.cmdReplace = new global::Gtk.Button ();
		this.cmdReplace.CanFocus = true;
		this.cmdReplace.Name = "cmdReplace";
		this.cmdReplace.UseUnderline = true;
		this.cmdReplace.Label = global::Mono.Unix.Catalog.GetString ("Replace");
		this.cntFixed.Add (this.cmdReplace);
		global::Gtk.Fixed.FixedChild w13 = ((global::Gtk.Fixed.FixedChild)(this.cntFixed [this.cmdReplace]));
		w13.X = 540;
		w13.Y = 106;
		this.Add (this.cntFixed);
		if ((this.Child != null)) {
			this.Child.ShowAll ();
		}
		this.DefaultWidth = 815;
		this.DefaultHeight = 482;
		this.Show ();
		this.DeleteEvent += new global::Gtk.DeleteEventHandler (this.OnDeleteEvent);
		this.cmdReplace.Clicked += new global::System.EventHandler (this.OnCmdReplaceClicked);
	}
}