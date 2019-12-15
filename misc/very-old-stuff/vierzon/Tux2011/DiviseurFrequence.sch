<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Clk10KHz" />
        <signal name="Clk10Hz" />
        <signal name="Clk100KHz" />
        <signal name="Clk28MHz" />
        <port polarity="BiDirectional" name="Clk10KHz" />
        <port polarity="BiDirectional" name="Clk10Hz" />
        <port polarity="BiDirectional" name="Clk100KHz" />
        <port polarity="Input" name="Clk28MHz" />
        <blockdef name="DiviseurDeFrequence">
            <timestamp>2011-3-10T19:5:56</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="DiviseurDeFrquence10KHz">
            <timestamp>2011-4-20T14:55:24</timestamp>
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
        </blockdef>
        <blockdef name="DiviseurDeFrequence10Hz">
            <timestamp>2011-4-14T9:9:14</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="DiviseurDeFrquence10KHz" name="XLXI_2">
            <blockpin signalname="Clk100KHz" name="Clk100KHz" />
            <blockpin signalname="Clk10KHz" name="Clk10KHz" />
        </block>
        <block symbolname="DiviseurDeFrequence10Hz" name="XLXI_3">
            <blockpin signalname="Clk10KHz" name="Clk10KHz" />
            <blockpin signalname="Clk10Hz" name="Clk10Hz" />
        </block>
        <block symbolname="DiviseurDeFrequence" name="XLXI_1">
            <blockpin signalname="Clk28MHz" name="Clk28MHz" />
            <blockpin signalname="Clk100KHz" name="Clk100KHz" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1900" height="1344">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="Clk10KHz">
            <wire x2="1120" y1="784" y2="784" x1="464" />
            <wire x2="464" y1="784" y2="912" x1="464" />
            <wire x2="720" y1="912" y2="912" x1="464" />
            <wire x2="1120" y1="704" y2="704" x1="1104" />
            <wire x2="1296" y1="704" y2="704" x1="1120" />
            <wire x2="1120" y1="704" y2="784" x1="1120" />
        </branch>
        <branch name="Clk10Hz">
            <wire x2="1312" y1="912" y2="912" x1="1104" />
        </branch>
        <branch name="Clk100KHz">
            <wire x2="1120" y1="576" y2="576" x1="464" />
            <wire x2="464" y1="576" y2="704" x1="464" />
            <wire x2="720" y1="704" y2="704" x1="464" />
            <wire x2="1120" y1="496" y2="496" x1="1104" />
            <wire x2="1296" y1="496" y2="496" x1="1120" />
            <wire x2="1120" y1="496" y2="576" x1="1120" />
        </branch>
        <branch name="Clk28MHz">
            <wire x2="720" y1="496" y2="496" x1="448" />
        </branch>
        <instance x="720" y="736" name="XLXI_2" orien="R0">
        </instance>
        <instance x="720" y="944" name="XLXI_3" orien="R0">
        </instance>
        <instance x="720" y="528" name="XLXI_1" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1296" y="704" name="Clk10KHz" orien="R0" />
        <iomarker fontsize="28" x="1312" y="912" name="Clk10Hz" orien="R0" />
        <iomarker fontsize="28" x="1296" y="496" name="Clk100KHz" orien="R0" />
        <iomarker fontsize="28" x="448" y="496" name="Clk28MHz" orien="R180" />
    </sheet>
</drawing>