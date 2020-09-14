<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="xbr" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Sortie" />
        <signal name="XLXN_2" />
        <signal name="entree" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="clk10kHz" />
        <port polarity="Output" name="Sortie" />
        <port polarity="Input" name="entree" />
        <port polarity="Input" name="clk10kHz" />
        <blockdef name="fd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="cb8ce">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="320" y1="-128" y2="-128" x1="384" />
            <rect width="64" x="320" y="-268" height="24" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="320" y1="-192" y2="-192" x1="384" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="fd" name="XLXI_1">
            <blockpin signalname="XLXN_2" name="C" />
            <blockpin signalname="entree" name="D" />
            <blockpin signalname="Sortie" name="Q" />
        </block>
        <block symbolname="cb8ce" name="XLXI_2">
            <blockpin signalname="clk10kHz" name="C" />
            <blockpin signalname="XLXN_5" name="CE" />
            <blockpin signalname="XLXN_4" name="CLR" />
            <blockpin name="CEO" />
            <blockpin name="Q(7:0)" />
            <blockpin signalname="XLXN_2" name="TC" />
        </block>
        <block symbolname="vcc" name="XLXI_3">
            <blockpin signalname="XLXN_5" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_4">
            <blockpin signalname="XLXN_4" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1900" height="1344">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="1232" y="832" name="XLXI_1" orien="R0" />
        <branch name="Sortie">
            <wire x2="1648" y1="576" y2="576" x1="1616" />
        </branch>
        <iomarker fontsize="28" x="1648" y="576" name="Sortie" orien="R0" />
        <instance x="400" y="832" name="XLXI_2" orien="R0" />
        <branch name="XLXN_2">
            <wire x2="1232" y1="704" y2="704" x1="784" />
        </branch>
        <branch name="entree">
            <wire x2="400" y1="192" y2="192" x1="288" />
            <wire x2="1184" y1="192" y2="192" x1="400" />
            <wire x2="1184" y1="192" y2="576" x1="1184" />
            <wire x2="1232" y1="576" y2="576" x1="1184" />
        </branch>
        <instance x="224" y="608" name="XLXI_3" orien="R0" />
        <instance x="224" y="976" name="XLXI_4" orien="R0" />
        <branch name="XLXN_4">
            <wire x2="400" y1="800" y2="800" x1="288" />
            <wire x2="288" y1="800" y2="848" x1="288" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="288" y1="608" y2="640" x1="288" />
            <wire x2="400" y1="640" y2="640" x1="288" />
        </branch>
        <branch name="clk10kHz">
            <wire x2="400" y1="704" y2="704" x1="288" />
        </branch>
        <iomarker fontsize="28" x="288" y="192" name="entree" orien="R180" />
        <iomarker fontsize="28" x="288" y="704" name="clk10kHz" orien="R180" />
    </sheet>
</drawing>