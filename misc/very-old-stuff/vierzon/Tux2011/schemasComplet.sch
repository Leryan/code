<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
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
        <signal name="ledV" />
        <signal name="ledR" />
        <signal name="XLXN_27" />
        <signal name="XLXN_26" />
        <signal name="FinCourse" />
        <signal name="XLXN_377(15:0)" />
        <signal name="Jack" />
        <signal name="XLXN_389(3:0)" />
        <signal name="XLXN_390" />
        <signal name="XLXN_391(3:0)" />
        <signal name="led1" />
        <signal name="led2" />
        <signal name="led3" />
        <signal name="led4" />
        <signal name="XLXN_393" />
        <signal name="XLXN_397" />
        <port polarity="Input" name="Clk28MHz" />
        <port polarity="Output" name="inGpGmDpDm(3:0)" />
        <port polarity="Input" name="ObstacleD" />
        <port polarity="Input" name="ObstacleG" />
        <port polarity="Input" name="TSOP(7:0)" />
        <port polarity="Output" name="ledV" />
        <port polarity="Output" name="ledR" />
        <port polarity="Input" name="FinCourse" />
        <port polarity="Input" name="Jack" />
        <port polarity="Output" name="led1" />
        <port polarity="Output" name="led2" />
        <port polarity="Output" name="led3" />
        <port polarity="Output" name="led4" />
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
            <timestamp>2011-5-27T19:59:33</timestamp>
            <line x2="0" y1="400" y2="400" x1="64" />
            <rect width="64" x="432" y="-364" height="24" />
            <line x2="496" y1="-352" y2="-352" x1="432" />
            <rect width="64" x="0" y="-828" height="24" />
            <line x2="0" y1="-816" y2="-816" x1="64" />
            <rect width="64" x="0" y="-604" height="24" />
            <line x2="0" y1="-592" y2="-592" x1="64" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="260" height="24" />
            <line x2="0" y1="272" y2="272" x1="64" />
            <line x2="0" y1="192" y2="192" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="372" x="64" y="-888" height="1468" />
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
        <blockdef name="suiviBalise">
            <timestamp>2011-5-27T19:59:29</timestamp>
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
            <timestamp>2011-5-27T19:59:18</timestamp>
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
        <blockdef name="telecommander">
            <timestamp>2011-5-27T19:59:23</timestamp>
            <line x2="560" y1="32" y2="32" x1="496" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="496" y="-108" height="24" />
            <line x2="560" y1="-96" y2="-96" x1="496" />
            <rect width="432" x="64" y="-192" height="264" />
        </blockdef>
        <blockdef name="buf">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <blockdef name="constant">
            <timestamp>2006-1-1T10:10:10</timestamp>
            <rect width="112" x="0" y="0" height="64" />
            <line x2="112" y1="32" y2="32" x1="144" />
        </blockdef>
        <block symbolname="DiviseurFrequence" name="XLXI_8">
            <blockpin signalname="Clk28MHz" name="Clk28MHz" />
            <blockpin signalname="horloge10KHz" name="Clk10KHz" />
            <blockpin signalname="horloge10Hz" name="Clk10Hz" />
            <blockpin signalname="horloge100KHz" name="Clk100KHz" />
        </block>
        <block symbolname="suiviBalise" name="XLXI_17">
            <blockpin signalname="XLXN_377(15:0)" name="signalMLI(15:0)" />
            <blockpin signalname="TSOP(7:0)" name="TSOP(7:0)" />
            <blockpin signalname="horloge100KHz" name="Clk100KHz" />
            <blockpin signalname="XLXN_177(3:0)" name="inGpGmDpDm(3:0)" />
            <blockpin signalname="XLXN_178" name="defaut" />
        </block>
        <block symbolname="EviteObstacle" name="XLXI_18">
            <blockpin signalname="XLXN_178" name="defaut" />
            <blockpin signalname="horloge10KHz" name="Clk10KHz" />
            <blockpin signalname="ObstacleD" name="ObstacleD" />
            <blockpin signalname="ObstacleG" name="ObstacleG" />
            <blockpin signalname="XLXN_377(15:0)" name="VecteurMli(15:0)" />
            <blockpin signalname="XLXN_184" name="CycleEvitement" />
            <blockpin signalname="XLXN_183(3:0)" name="signalMoteur(3:0)" />
        </block>
        <block symbolname="Multiplexers" name="XLXI_10">
            <blockpin signalname="Jack" name="Jack" />
            <blockpin signalname="XLXN_184" name="Mode_Evitement" />
            <blockpin signalname="XLXN_390" name="Fin_Course" />
            <blockpin signalname="XLXN_397" name="fin_com" />
            <blockpin signalname="XLXN_177(3:0)" name="SuivitBalise(3:0)" />
            <blockpin signalname="XLXN_183(3:0)" name="Cycle_Evitement(3:0)" />
            <blockpin signalname="XLXN_389(3:0)" name="Debut_Fin_Course(3:0)" />
            <blockpin signalname="XLXN_391(3:0)" name="telecommander(3:0)" />
            <blockpin signalname="inGpGmDpDm(3:0)" name="Moteurs(3:0)" />
        </block>
        <block symbolname="SignalMli" name="XLXI_9">
            <blockpin signalname="horloge10KHz" name="H10kHz" />
            <blockpin signalname="XLXN_377(15:0)" name="VecteurMli(15:0)" />
        </block>
        <block symbolname="inv" name="XLXI_12">
            <blockpin signalname="XLXN_27" name="I" />
            <blockpin signalname="ledV" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_11">
            <blockpin signalname="XLXN_26" name="I" />
            <blockpin signalname="ledR" name="O" />
        </block>
        <block symbolname="Debut_Fin_Course" name="XLXI_4">
            <blockpin signalname="Jack" name="Jack" />
            <blockpin signalname="FinCourse" name="FinCourse" />
            <blockpin signalname="horloge10Hz" name="Clk10Hz" />
            <blockpin signalname="XLXN_26" name="LEDrouge" />
            <blockpin signalname="XLXN_27" name="LEDverte" />
            <blockpin signalname="XLXN_390" name="MemoFinCourse" />
            <blockpin signalname="XLXN_389(3:0)" name="SignalMoteur(3:0)" />
        </block>
        <block symbolname="telecommander" name="XLXI_75">
            <blockpin signalname="horloge10KHz" name="Clk10KHz" />
            <blockpin signalname="Jack" name="Jack" />
            <blockpin signalname="XLXN_377(15:0)" name="VecteurMli(15:0)" />
            <blockpin signalname="XLXN_397" name="fin_com" />
            <blockpin signalname="XLXN_391(3:0)" name="signalMoteur(3:0)" />
        </block>
        <block symbolname="buf" name="XLXI_79">
            <blockpin signalname="XLXN_393" name="I" />
            <blockpin signalname="led1" name="O" />
        </block>
        <block symbolname="constant" name="XLXI_80">
            <attr value="1" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_393" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_78">
            <blockpin signalname="XLXN_393" name="I" />
            <blockpin signalname="led2" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_77">
            <blockpin signalname="XLXN_393" name="I" />
            <blockpin signalname="led3" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_76">
            <blockpin signalname="XLXN_393" name="I" />
            <blockpin signalname="led4" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="2688" height="1900">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="320" y="240" name="XLXI_8" orien="R0">
        </instance>
        <instance x="320" y="608" name="XLXI_17" orien="R0">
        </instance>
        <branch name="horloge100KHz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="896" y="144" type="branch" />
            <wire x2="896" y1="144" y2="144" x1="768" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="896" y="208" type="branch" />
            <wire x2="896" y1="208" y2="208" x1="768" />
        </branch>
        <branch name="horloge10Hz">
            <attrtext style="alignment:SOFT-LEFT" attrname="Name" x="896" y="272" type="branch" />
            <wire x2="896" y1="272" y2="272" x1="768" />
        </branch>
        <branch name="Clk28MHz">
            <wire x2="320" y1="144" y2="144" x1="224" />
        </branch>
        <branch name="inGpGmDpDm(3:0)">
            <wire x2="2368" y1="912" y2="912" x1="2336" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="240" y="832" type="branch" />
            <wire x2="320" y1="832" y2="832" x1="240" />
        </branch>
        <instance x="1056" y="800" name="XLXI_18" orien="R0">
        </instance>
        <branch name="XLXN_177(3:0)">
            <wire x2="1840" y1="448" y2="448" x1="816" />
        </branch>
        <branch name="XLXN_178">
            <wire x2="1056" y1="576" y2="576" x1="816" />
        </branch>
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="1024" y="768" type="branch" />
            <wire x2="1056" y1="768" y2="768" x1="1024" />
        </branch>
        <branch name="ObstacleD">
            <wire x2="1056" y1="640" y2="640" x1="1008" />
        </branch>
        <branch name="ObstacleG">
            <wire x2="1056" y1="704" y2="704" x1="1008" />
        </branch>
        <branch name="XLXN_183(3:0)">
            <wire x2="1840" y1="672" y2="672" x1="1680" />
        </branch>
        <branch name="XLXN_184">
            <wire x2="1840" y1="800" y2="800" x1="1680" />
        </branch>
        <branch name="horloge100KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="256" y="512" type="branch" />
            <wire x2="320" y1="512" y2="512" x1="256" />
        </branch>
        <branch name="TSOP(7:0)">
            <wire x2="320" y1="448" y2="448" x1="224" />
        </branch>
        <instance x="1840" y="1264" name="XLXI_10" orien="R0">
        </instance>
        <instance x="320" y="864" name="XLXI_9" orien="R0">
        </instance>
        <iomarker fontsize="28" x="2368" y="912" name="inGpGmDpDm(3:0)" orien="R0" />
        <iomarker fontsize="28" x="224" y="448" name="TSOP(7:0)" orien="R180" />
        <iomarker fontsize="28" x="224" y="144" name="Clk28MHz" orien="R180" />
        <iomarker fontsize="28" x="1008" y="704" name="ObstacleG" orien="R180" />
        <iomarker fontsize="28" x="1008" y="640" name="ObstacleD" orien="R180" />
        <instance x="1056" y="1776" name="XLXI_12" orien="R0" />
        <instance x="1056" y="1696" name="XLXI_11" orien="R0" />
        <branch name="ledV">
            <wire x2="1312" y1="1744" y2="1744" x1="1280" />
        </branch>
        <branch name="ledR">
            <wire x2="1312" y1="1664" y2="1664" x1="1280" />
        </branch>
        <branch name="XLXN_27">
            <wire x2="1056" y1="1744" y2="1744" x1="944" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="1056" y1="1664" y2="1664" x1="944" />
        </branch>
        <branch name="horloge10Hz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="224" y="1648" type="branch" />
            <wire x2="320" y1="1648" y2="1648" x1="224" />
        </branch>
        <branch name="FinCourse">
            <wire x2="320" y1="1552" y2="1552" x1="224" />
        </branch>
        <iomarker fontsize="28" x="1312" y="1744" name="ledV" orien="R0" />
        <iomarker fontsize="28" x="1312" y="1664" name="ledR" orien="R0" />
        <branch name="horloge10KHz">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="240" y="1168" type="branch" />
            <wire x2="320" y1="1168" y2="1168" x1="240" />
        </branch>
        <instance x="320" y="1664" name="XLXI_4" orien="R0">
        </instance>
        <iomarker fontsize="28" x="224" y="1552" name="FinCourse" orien="R180" />
        <instance x="320" y="1264" name="XLXI_75" orien="R0">
        </instance>
        <branch name="XLXN_377(15:0)">
            <wire x2="320" y1="576" y2="576" x1="256" />
            <wire x2="256" y1="576" y2="688" x1="256" />
            <wire x2="784" y1="688" y2="688" x1="256" />
            <wire x2="784" y1="688" y2="832" x1="784" />
            <wire x2="1056" y1="832" y2="832" x1="784" />
            <wire x2="784" y1="832" y2="960" x1="784" />
            <wire x2="272" y1="960" y2="1104" x1="272" />
            <wire x2="320" y1="1104" y2="1104" x1="272" />
            <wire x2="784" y1="960" y2="960" x1="272" />
            <wire x2="784" y1="832" y2="832" x1="704" />
        </branch>
        <branch name="XLXN_389(3:0)">
            <wire x2="1840" y1="1536" y2="1536" x1="944" />
        </branch>
        <branch name="XLXN_390">
            <wire x2="1840" y1="1456" y2="1456" x1="944" />
        </branch>
        <branch name="XLXN_391(3:0)">
            <wire x2="1840" y1="1168" y2="1168" x1="880" />
        </branch>
        <iomarker fontsize="28" x="144" y="1456" name="Jack" orien="R180" />
        <instance x="1456" y="384" name="XLXI_79" orien="R0" />
        <instance x="1200" y="80" name="XLXI_80" orien="R0">
        </instance>
        <instance x="1456" y="304" name="XLXI_78" orien="R0" />
        <instance x="1456" y="224" name="XLXI_77" orien="R0" />
        <instance x="1456" y="144" name="XLXI_76" orien="R0" />
        <branch name="led1">
            <wire x2="1712" y1="352" y2="352" x1="1680" />
        </branch>
        <branch name="led2">
            <wire x2="1712" y1="272" y2="272" x1="1680" />
        </branch>
        <branch name="led3">
            <wire x2="1712" y1="192" y2="192" x1="1680" />
        </branch>
        <branch name="led4">
            <wire x2="1712" y1="112" y2="112" x1="1680" />
        </branch>
        <branch name="XLXN_393">
            <wire x2="1408" y1="112" y2="112" x1="1344" />
            <wire x2="1456" y1="112" y2="112" x1="1408" />
            <wire x2="1408" y1="112" y2="192" x1="1408" />
            <wire x2="1456" y1="192" y2="192" x1="1408" />
            <wire x2="1408" y1="192" y2="272" x1="1408" />
            <wire x2="1456" y1="272" y2="272" x1="1408" />
            <wire x2="1408" y1="272" y2="352" x1="1408" />
            <wire x2="1456" y1="352" y2="352" x1="1408" />
        </branch>
        <iomarker fontsize="28" x="1712" y="352" name="led1" orien="R0" />
        <iomarker fontsize="28" x="1712" y="272" name="led2" orien="R0" />
        <iomarker fontsize="28" x="1712" y="192" name="led3" orien="R0" />
        <iomarker fontsize="28" x="1712" y="112" name="led4" orien="R0" />
        <branch name="Jack">
            <wire x2="288" y1="1456" y2="1456" x1="144" />
            <wire x2="320" y1="1456" y2="1456" x1="288" />
            <wire x2="320" y1="1232" y2="1232" x1="288" />
            <wire x2="288" y1="1232" y2="1376" x1="288" />
            <wire x2="288" y1="1376" y2="1456" x1="288" />
            <wire x2="1824" y1="1376" y2="1376" x1="288" />
            <wire x2="1840" y1="1296" y2="1296" x1="1824" />
            <wire x2="1824" y1="1296" y2="1376" x1="1824" />
        </branch>
        <branch name="XLXN_397">
            <wire x2="1440" y1="1296" y2="1296" x1="880" />
            <wire x2="1440" y1="1296" y2="1664" x1="1440" />
            <wire x2="1840" y1="1664" y2="1664" x1="1440" />
        </branch>
    </sheet>
</drawing>