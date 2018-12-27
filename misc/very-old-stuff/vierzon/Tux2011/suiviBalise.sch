<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_3(2:0)" />
        <signal name="signalMLI(15:0)" />
        <signal name="inGpGmDpDm(3:0)" />
        <signal name="XLXN_5(7:0)" />
        <signal name="TSOP(7:0)" />
        <signal name="defaut" />
        <signal name="Clk100KHz" />
        <signal name="XLXN_6" />
        <port polarity="Input" name="signalMLI(15:0)" />
        <port polarity="Output" name="inGpGmDpDm(3:0)" />
        <port polarity="Input" name="TSOP(7:0)" />
        <port polarity="Output" name="defaut" />
        <port polarity="Input" name="Clk100KHz" />
        <blockdef name="calculeEcartBalise">
            <timestamp>2011-3-28T14:39:12</timestamp>
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-192" height="192" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
        </blockdef>
        <blockdef name="correcteurBalise">
            <timestamp>2011-5-27T10:18:57</timestamp>
            <rect width="64" x="320" y="20" height="24" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="256" x="64" y="-256" height="320" />
        </blockdef>
        <blockdef name="decodeCapteurs">
            <timestamp>2011-5-27T10:51:2</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="368" y="-108" height="24" />
            <line x2="432" y1="-96" y2="-96" x1="368" />
            <rect width="304" x="64" y="-128" height="192" />
        </blockdef>
        <block symbolname="correcteurBalise" name="XLXI_2">
            <blockpin signalname="XLXN_6" name="D_G" />
            <blockpin signalname="defaut" name="defaut" />
            <blockpin signalname="XLXN_3(2:0)" name="ecart(2:0)" />
            <blockpin signalname="signalMLI(15:0)" name="vitesseMli(15:0)" />
            <blockpin signalname="inGpGmDpDm(3:0)" name="inGpGmDpDm(3:0)" />
        </block>
        <block symbolname="calculeEcartBalise" name="XLXI_1">
            <blockpin signalname="XLXN_5(7:0)" name="CaptTsop(7:0)" />
            <blockpin signalname="XLXN_6" name="D_G" />
            <blockpin signalname="defaut" name="defaut" />
            <blockpin signalname="XLXN_3(2:0)" name="ecart(2:0)" />
        </block>
        <block symbolname="decodeCapteurs" name="XLXI_5">
            <blockpin signalname="TSOP(7:0)" name="TSOP(7:0)" />
            <blockpin signalname="Clk100KHz" name="Clk100KHz" />
            <blockpin signalname="XLXN_5(7:0)" name="EtatCapteur(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="1900" height="1344">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <branch name="XLXN_3(2:0)">
            <wire x2="1184" y1="704" y2="704" x1="1104" />
        </branch>
        <branch name="signalMLI(15:0)">
            <wire x2="704" y1="816" y2="816" x1="288" />
            <wire x2="704" y1="768" y2="816" x1="704" />
            <wire x2="1184" y1="768" y2="768" x1="704" />
        </branch>
        <branch name="inGpGmDpDm(3:0)">
            <wire x2="1600" y1="832" y2="832" x1="1568" />
        </branch>
        <instance x="1184" y="800" name="XLXI_2" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1600" y="832" name="inGpGmDpDm(3:0)" orien="R0" />
        <instance x="720" y="736" name="XLXI_1" orien="R0">
        </instance>
        <instance x="256" y="672" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_5(7:0)">
            <wire x2="704" y1="576" y2="576" x1="688" />
            <wire x2="720" y1="576" y2="576" x1="704" />
        </branch>
        <branch name="TSOP(7:0)">
            <wire x2="240" y1="576" y2="576" x1="224" />
            <wire x2="256" y1="576" y2="576" x1="240" />
        </branch>
        <iomarker fontsize="28" x="224" y="576" name="TSOP(7:0)" orien="R180" />
        <branch name="defaut">
            <wire x2="1168" y1="640" y2="640" x1="1104" />
            <wire x2="1184" y1="640" y2="640" x1="1168" />
            <wire x2="1376" y1="336" y2="336" x1="1168" />
            <wire x2="1168" y1="336" y2="640" x1="1168" />
        </branch>
        <iomarker fontsize="28" x="1376" y="336" name="defaut" orien="R0" />
        <branch name="Clk100KHz">
            <wire x2="256" y1="704" y2="704" x1="240" />
        </branch>
        <iomarker fontsize="28" x="240" y="704" name="Clk100KHz" orien="R180" />
        <iomarker fontsize="28" x="288" y="816" name="signalMLI(15:0)" orien="R180" />
        <branch name="XLXN_6">
            <wire x2="1184" y1="576" y2="576" x1="1104" />
        </branch>
    </sheet>
</drawing>