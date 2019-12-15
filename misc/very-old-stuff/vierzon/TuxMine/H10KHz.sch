<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="xbr" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="HorlogeR" />
        <signal name="HorlogeRC" />
        <signal name="Clk10KHz" />
        <port polarity="Output" name="HorlogeR" />
        <port polarity="Input" name="HorlogeRC" />
        <port polarity="Output" name="Clk10KHz" />
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <block symbolname="inv" name="XLXI_1">
            <blockpin signalname="HorlogeRC" name="I" />
            <blockpin signalname="HorlogeR" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_2">
            <blockpin signalname="HorlogeR" name="I" />
            <blockpin signalname="Clk10KHz" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1900" height="1344">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="464" y="432" name="XLXI_1" orien="R0" />
        <instance x="848" y="432" name="XLXI_2" orien="R0" />
        <branch name="HorlogeR">
            <wire x2="768" y1="400" y2="400" x1="688" />
            <wire x2="848" y1="400" y2="400" x1="768" />
            <wire x2="768" y1="304" y2="400" x1="768" />
        </branch>
        <iomarker fontsize="28" x="768" y="304" name="HorlogeR" orien="R270" />
        <branch name="HorlogeRC">
            <wire x2="464" y1="400" y2="400" x1="432" />
        </branch>
        <iomarker fontsize="28" x="432" y="400" name="HorlogeRC" orien="R180" />
        <branch name="Clk10KHz">
            <wire x2="1104" y1="400" y2="400" x1="1072" />
        </branch>
        <iomarker fontsize="28" x="1104" y="400" name="Clk10KHz" orien="R0" />
    </sheet>
</drawing>