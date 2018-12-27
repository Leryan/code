<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_30" />
        <signal name="led4" />
        <signal name="led3" />
        <signal name="horloge100KHz" />
        <signal name="horloge10KHz" />
        <signal name="horloge10Hz" />
        <signal name="Clk28MHz" />
        <signal name="inGpGmDpDm(3:0)" />
        <signal name="XLXN_177(3:0)" />
        <signal name="XLXN_178" />
        <signal name="ObstacleD" />
        <signal name="ObstacleG" />
        <signal name="XLXN_183(3:0)" />
        <signal name="XLXN_184" />
        <signal name="TSOP(7:0)" />
        <signal name="XLXN_210(15:0)" />
        <signal name="led1" />
        <signal name="led2" />
        <signal name="XLXN_27" />
        <signal name="XLXN_26" />
        <signal name="FinCourse" />
        <signal name="Jack" />
        <signal name="XLXN_239(3:0)" />
        <signal name="XLXN_240" />
        <port polarity="Output" name="led4" />
        <port polarity="Output" name="led3" />
        <port polarity="Input" name="Clk28MHz" />
        <port polarity="Output" name="inGpGmDpDm(3:0)" />
        <port polarity="Input" name="ObstacleD" />
        <port polarity="Input" name="ObstacleG" />
        <port polarity="Input" name="TSOP(7:0)" />
        <port polarity="Output" name="led1" />
        <port polarity="Output" name="led2" />
        <port polarity="Input" name="FinCourse" />
        <port polarity="Input" name="Jack" />
        <blockdef name="Debut_Fin_Course">
            <timestamp>2011-5-12T15:14:56</timestamp>
            <rect width="496" x="64" y="-256" height="372" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="0" y1="-112" y2="-112" x1="64" />
            <line x2="0" y1="-16" y2="-16" x1="64" />
            <rect width="64" x="560" y="-140" height="24" />
            <line x2="624" y1="-128" y2="-128" x1="560" />
            <line x2="624" y1="-208" y2="-208" x1="560" />
            <line x2="624" y1="0" y2="0" x1="560" />
            <line x2="624" y1="80" y2="80" x1="560" />
        </blockdef>
        <blockdef name="DiviseurFrequence">
            <timestamp>2011-4-21T18:25:28</timestamp>
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="320" x="64" y="-128" height="192" />
            <line x2="448" y1="32" y2="32" x1="384" />
            <line x2="448" y1="-96" y2="-96" x1="384" />
            <line x2="448" y1="-32" y2="-32" x1="384" />
        </blockdef>
        <blockdef name="SignalMli">
            <timestamp>2011-4-21T18:25:24</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="Multiplexers">
            <timestamp>2011-5-17T7:36:56</timestamp>
            <rect width="64" x="432" y="-364" height="24" />
            <line x2="496" y1="-352" y2="-352" x1="432" />
            <rect width="64" x="0" y="-828" height="24" />
            <line x2="0" y1="-816" y2="-816" x1="64" />
            <rect width="64" x="0" y="-604" height="24" />
            <line x2="0" y1="-592" y2="-592" x1="64" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <rect width="64" x="0" y="36" height="24" />
            <line x2="0" y1="48" y2="48" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="372" x="64" y="-968" height="1076" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="constant">
            <timestamp>2006-1-1T10:10:10</timestamp>
            <rect width="112" x="0" y="0" height="64" />
            <line x2="112" y1="32" y2="32" x1="144" />
        </blockdef>
        <blockdef name="buf">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <blockdef name="suiviBalise">
            <timestamp>2011-5-12T17:9:52</timestamp>
            <rect width="368" x="64" y="-192" height="192" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="496" y1="-32" y2="-32" x1="432" />
            <rect width="64" x="432" y="-172" height="24" />
            <line x2="496" y1="-160" y2="-160" x1="432" />
        </blockdef>
        <blockdef name="EviteObstacle">
            <timestamp>2011-5-12T17:17:14</timestamp>
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="624" y1="0" y2="0" x1="560" />
            <rect width="64" x="560" y="-140" height="24" />
            <line x2="624" y1="-128" y2="-128" x1="560" />
            <rect width="496" x="64" y="-264" height="320" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
        </blockdef>
        <block symbolname="DiviseurFrequence" name="XLXI_8">
            <blockpin signalname="Clk28MHz" name="Clk28MHz" />
            <blockpin signalname="horloge10KHz" name="Clk10KHz" />
            <blockpin signalname="horloge10Hz" name="Clk10Hz" />
            <blockpin signalname="horloge100KHz" name="Clk100KHz" />
        </block>
        <block symbolname="suiviBalise" name="XLXI_17">
            <blockpin signalname="XLXN_210(15:0)" name="signalMLI(15:0)" />
            <blockpin signalname="TSOP(7:0)" name="TSOP(7:0)" />
            <blockpin signalname="horloge100KHz" name="Clk100KHz" />
            <blockpin signalname="XLXN_177(3:0)" name="inGpGmDpDm(3:0)" />
            <blockpin signalname="XLXN_178" name="defaut" />
        </block>
        <block symbolname="constant" name="XLXI_13">
            <attr value="1" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_30" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_15">
            <blockpin signalname="XLXN_30" name="I" />
            <blockpin signalname="led4" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_14">
            <blockpin signalname="XLXN_30" name="I" />
            <blockpin signalname="led3" name="O" />
        </block>
        <block symbolname="EviteObstacle" name="XLXI_18">
            <blockpin signalname="XLXN_178" name="defaut" />
            <blockpin signalname="XLXN_184" name="CycleEvitement" />
            <blockpin signalname="XLXN_183(3:0)" name="signalMoteur(3:0)" />
            <blockpin signalname="ObstacleD" name="ObstacleD" />
            <blockpin signalname="ObstacleG" name="ObstacleG" />
            <blockpin signalname="XLXN_210(15:0)" name="VecteurMli(15:0)" />
            <blockpin signalname="horloge10KHz" name="Clk10KHz" />
        </block>
        <block symbolname="Multiplexers" name="XLXI_10">
            <blockpin signalname="XLXN_184" name="Mode_Evitement" />
            <blockpin signalname="XLXN_177(3:0)" name="SuivitBalise(3:0)" />
            <blockpin signalname="XLXN_183(3:0)" name="Cycle_Evitement(3:0)" />
            <blockpin signalname="inGpGmDpDm(3:0)" name="Moteurs(3:0)" />
            <blockpin signalname="Jack" name="Jack" />
            <blockpin signalname="XLXN_240" name="Fin_Course" />
            <blockpin signalname="XLXN_239(3:0)" name="Debut_Fin_Course(3:0)" />
        </block>
        <block symbolname="SignalMli" name="XLXI_9">
            <blockpin signalname="horloge10KHz" name="H10kHz" />
            <blockpin signalname="XLXN_210(15:0)" name="VecteurMli(15:0)" />
        </block>
        <block symbolname="inv" name="XLXI_12">
            <blockpin signalname="XLXN_27" name="I" />
            <blockpin signalname="led1" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_11">
            <blockpin signalname="XLXN_26" name="I" />
            <blockpin signalname="led2" name="O" />
        </block>
        <block symbolname="Debut_Fin_Course" name="XLXI_4">
            <blockpin signalname="Jack" name="Jack" />
            <blockpin signalname="FinCourse" name="FinCourse" />
            <blockpin signalname="horloge10Hz" name="Clk10Hz" />
            <blockpin signalname="XLXN_26" name="LEDrouge" />
            <blockpin signalname="XLXN_27" name="LEDverte" />
            <blockpin signalname="XLXN_240" name="MemoFinCourse" />
            <blockpin signalname="XLXN_239(3:0)" name="SignalMoteur(3:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="2688" height="1900">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="336" y="352" name="XLXI_8" orien="R0">
        </instance>
        <instance x="336" y="720" name="XLXI_17" orien="R0">
        </instance>
        <instance x="1232" y="240" name="XLXI_13" orien="R0">
        </instance>
        <instance x="1520" y="384" name="XLXI_15" orien="R0" />
        <instance x="1520" y="304" name="XLXI_14" orien="R0" />
        <branch name="XLXN_30">
            <wire x2="1456" y1="272" y2="272" x1="1376" />
            <wire x2="1520" y1="272" y2="272" x1="1456" />
            <wire x2="1456" y1="272" y2="352" x1="1456" />
            <wire x2="1520" y1="352" y2="352" x1="1456" />
        </branch>
        <branch name="led4">
            <wire x2="1776" y1="352" y2="352" x1="1744" />
        </branch>
        <branch name="led3">
            <wire x2="1776" y1="272" y2="272" x1="1744" />
        </branch>
        <branch name="horloge100KHz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="912" y="256" type="branch" />
            <wire x2="912" y1="256" y2="256" x1="784" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="912" y="320" type="branch" />
            <wire x2="912" y1="320" y2="320" x1="784" />
        </branch>
        <branch name="horloge10Hz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="912" y="384" type="branch" />
            <wire x2="912" y1="384" y2="384" x1="784" />
        </branch>
        <branch name="Clk28MHz">
            <wire x2="336" y1="256" y2="256" x1="240" />
        </branch>
        <branch name="inGpGmDpDm(3:0)">
            <wire x2="2384" y1="1024" y2="1024" x1="2352" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="256" y="944" type="branch" />
            <wire x2="336" y1="944" y2="944" x1="256" />
        </branch>
        <instance x="1072" y="912" name="XLXI_18" orien="R0">
        </instance>
        <branch name="XLXN_177(3:0)">
            <wire x2="1856" y1="560" y2="560" x1="832" />
        </branch>
        <branch name="XLXN_178">
            <wire x2="1072" y1="688" y2="688" x1="832" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1040" y="880" type="branch" />
            <wire x2="1072" y1="880" y2="880" x1="1040" />
        </branch>
        <branch name="ObstacleD">
            <wire x2="1072" y1="752" y2="752" x1="1024" />
        </branch>
        <branch name="ObstacleG">
            <wire x2="1072" y1="816" y2="816" x1="1024" />
        </branch>
        <branch name="XLXN_183(3:0)">
            <wire x2="1856" y1="784" y2="784" x1="1696" />
        </branch>
        <branch name="XLXN_184">
            <wire x2="1856" y1="912" y2="912" x1="1696" />
        </branch>
        <branch name="horloge100KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="272" y="624" type="branch" />
            <wire x2="336" y1="624" y2="624" x1="272" />
        </branch>
        <branch name="TSOP(7:0)">
            <wire x2="336" y1="560" y2="560" x1="240" />
        </branch>
        <instance x="1856" y="1376" name="XLXI_10" orien="R0">
        </instance>
        <instance x="336" y="976" name="XLXI_9" orien="R0">
        </instance>
        <branch name="XLXN_210(15:0)">
            <wire x2="336" y1="688" y2="688" x1="272" />
            <wire x2="272" y1="688" y2="800" x1="272" />
            <wire x2="800" y1="800" y2="800" x1="272" />
            <wire x2="800" y1="800" y2="944" x1="800" />
            <wire x2="1072" y1="944" y2="944" x1="800" />
            <wire x2="800" y1="944" y2="944" x1="720" />
        </branch>
        <instance x="1072" y="1664" name="XLXI_12" orien="R0" />
        <instance x="1072" y="1584" name="XLXI_11" orien="R0" />
        <branch name="led1">
            <wire x2="1328" y1="1632" y2="1632" x1="1296" />
        </branch>
        <branch name="led2">
            <wire x2="1328" y1="1552" y2="1552" x1="1296" />
        </branch>
        <branch name="XLXN_27">
            <wire x2="1072" y1="1632" y2="1632" x1="944" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="1072" y1="1552" y2="1552" x1="944" />
        </branch>
        <branch name="horloge10Hz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="224" y="1536" type="branch" />
            <wire x2="320" y1="1536" y2="1536" x1="224" />
        </branch>
        <branch name="FinCourse">
            <wire x2="320" y1="1440" y2="1440" x1="224" />
        </branch>
        <instance x="320" y="1552" name="XLXI_4" orien="R0">
        </instance>
        <branch name="Jack">
            <wire x2="240" y1="1344" y2="1344" x1="160" />
            <wire x2="320" y1="1344" y2="1344" x1="240" />
            <wire x2="240" y1="1184" y2="1344" x1="240" />
            <wire x2="1856" y1="1184" y2="1184" x1="240" />
        </branch>
        <branch name="XLXN_239(3:0)">
            <wire x2="1856" y1="1424" y2="1424" x1="944" />
        </branch>
        <branch name="XLXN_240">
            <wire x2="1856" y1="1344" y2="1344" x1="944" />
        </branch>
        <iomarker fontsize="28" x="1776" y="272" name="led3" orien="R0" />
        <iomarker fontsize="28" x="1776" y="352" name="led4" orien="R0" />
        <iomarker fontsize="28" x="2384" y="1024" name="inGpGmDpDm(3:0)" orien="R0" />
        <iomarker fontsize="28" x="240" y="560" name="TSOP(7:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="256" name="Clk28MHz" orien="R180" />
        <iomarker fontsize="28" x="1024" y="816" name="ObstacleG" orien="R180" />
        <iomarker fontsize="28" x="1024" y="752" name="ObstacleD" orien="R180" />
        <iomarker fontsize="28" x="1328" y="1632" name="led1" orien="R0" />
        <iomarker fontsize="28" x="1328" y="1552" name="led2" orien="R0" />
        <iomarker fontsize="28" x="224" y="1440" name="FinCourse" orien="R180" />
        <iomarker fontsize="28" x="160" y="1344" name="Jack" orien="R180" />
    </sheet>
</drawing>