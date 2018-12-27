<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_37(0:100)" />
        <signal name="Res_TSOP1" />
        <signal name="Res_TSOP2" />
        <signal name="Res_TSOP3" />
        <signal name="Res_TSOP6" />
        <signal name="Res_TSOP7" />
        <signal name="Res_TSOP8" />
        <signal name="XLXN_27(11:0)" />
        <signal name="tsop1" />
        <signal name="tsop2" />
        <signal name="tsop3" />
        <signal name="tsop4" />
        <signal name="tsop5" />
        <signal name="tsop6" />
        <signal name="tsop7" />
        <signal name="tsop8" />
        <signal name="Res_TSOP4" />
        <signal name="XLXN_55" />
        <signal name="Res_TSOP5" />
        <signal name="XLXN_7" />
        <signal name="HorlogeFPGA" />
        <port polarity="Output" name="Res_TSOP1" />
        <port polarity="Output" name="Res_TSOP2" />
        <port polarity="Output" name="Res_TSOP3" />
        <port polarity="Output" name="Res_TSOP6" />
        <port polarity="Output" name="Res_TSOP7" />
        <port polarity="Output" name="Res_TSOP8" />
        <port polarity="Input" name="tsop1" />
        <port polarity="Input" name="tsop2" />
        <port polarity="Input" name="tsop3" />
        <port polarity="Input" name="tsop4" />
        <port polarity="Input" name="tsop5" />
        <port polarity="Input" name="tsop6" />
        <port polarity="Input" name="tsop7" />
        <port polarity="Input" name="tsop8" />
        <port polarity="Output" name="Res_TSOP4" />
        <port polarity="Output" name="Res_TSOP5" />
        <port polarity="Input" name="HorlogeFPGA" />
        <blockdef name="decod53200">
            <timestamp>2011-5-29T19:8:41</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="Clk28MHzTo100KHz">
            <timestamp>2011-5-29T19:8:48</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="constant">
            <timestamp>2006-1-1T10:10:10</timestamp>
            <rect width="112" x="0" y="0" height="64" />
            <line x2="112" y1="32" y2="32" x1="144" />
        </blockdef>
        <block symbolname="decod53200" name="XLXI_2">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop2" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP2" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_3">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop3" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP3" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_4">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop4" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP4" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_5">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop5" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP5" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_6">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop6" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP6" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_7">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop7" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP7" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_8">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop8" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP8" name="capt" />
        </block>
        <block symbolname="constant" name="XLXI_14">
            <attr value="A00" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_27(11:0)" name="O" />
        </block>
        <block symbolname="decod53200" name="XLXI_1">
            <blockpin signalname="XLXN_7" name="clkDec53200" />
            <blockpin signalname="tsop1" name="tsop" />
            <blockpin signalname="XLXN_27(11:0)" name="code53200(11:0)" />
            <blockpin signalname="Res_TSOP1" name="capt" />
        </block>
        <block symbolname="Clk28MHzTo100KHz" name="XLXI_28">
            <blockpin signalname="HorlogeFPGA" name="Clk28MHz" />
            <blockpin signalname="XLXN_7" name="Clk100KHz" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1616" y="992" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1616" y="1216" name="XLXI_3" orien="R0">
        </instance>
        <instance x="1616" y="1424" name="XLXI_4" orien="R0">
        </instance>
        <instance x="1616" y="1632" name="XLXI_5" orien="R0">
        </instance>
        <instance x="1616" y="1840" name="XLXI_6" orien="R0">
        </instance>
        <instance x="1616" y="2048" name="XLXI_7" orien="R0">
        </instance>
        <instance x="1616" y="2256" name="XLXI_8" orien="R0">
        </instance>
        <branch name="Res_TSOP1">
            <wire x2="2192" y1="608" y2="608" x1="2000" />
            <wire x2="2192" y1="608" y2="1136" x1="2192" />
            <wire x2="2368" y1="1136" y2="1136" x1="2192" />
        </branch>
        <branch name="Res_TSOP2">
            <wire x2="2176" y1="832" y2="832" x1="2000" />
            <wire x2="2176" y1="832" y2="1200" x1="2176" />
            <wire x2="2368" y1="1200" y2="1200" x1="2176" />
        </branch>
        <branch name="Res_TSOP3">
            <wire x2="2160" y1="1056" y2="1056" x1="2000" />
            <wire x2="2160" y1="1056" y2="1264" x1="2160" />
            <wire x2="2368" y1="1264" y2="1264" x1="2160" />
        </branch>
        <branch name="Res_TSOP6">
            <wire x2="2192" y1="1680" y2="1680" x1="2000" />
            <wire x2="2192" y1="1456" y2="1680" x1="2192" />
            <wire x2="2368" y1="1456" y2="1456" x1="2192" />
        </branch>
        <branch name="Res_TSOP7">
            <wire x2="2208" y1="1888" y2="1888" x1="2000" />
            <wire x2="2208" y1="1520" y2="1888" x1="2208" />
            <wire x2="2368" y1="1520" y2="1520" x1="2208" />
        </branch>
        <branch name="Res_TSOP8">
            <wire x2="2224" y1="2096" y2="2096" x1="2000" />
            <wire x2="2224" y1="1584" y2="2096" x1="2224" />
            <wire x2="2368" y1="1584" y2="1584" x1="2224" />
        </branch>
        <instance x="1232" y="496" name="XLXI_14" orien="R0">
        </instance>
        <branch name="XLXN_27(11:0)">
            <wire x2="1488" y1="528" y2="528" x1="1376" />
            <wire x2="1488" y1="528" y2="736" x1="1488" />
            <wire x2="1616" y1="736" y2="736" x1="1488" />
            <wire x2="1488" y1="736" y2="960" x1="1488" />
            <wire x2="1616" y1="960" y2="960" x1="1488" />
            <wire x2="1488" y1="960" y2="1184" x1="1488" />
            <wire x2="1616" y1="1184" y2="1184" x1="1488" />
            <wire x2="1488" y1="1184" y2="1392" x1="1488" />
            <wire x2="1616" y1="1392" y2="1392" x1="1488" />
            <wire x2="1488" y1="1392" y2="1600" x1="1488" />
            <wire x2="1616" y1="1600" y2="1600" x1="1488" />
            <wire x2="1488" y1="1600" y2="1808" x1="1488" />
            <wire x2="1616" y1="1808" y2="1808" x1="1488" />
            <wire x2="1488" y1="1808" y2="2016" x1="1488" />
            <wire x2="1616" y1="2016" y2="2016" x1="1488" />
            <wire x2="1488" y1="2016" y2="2224" x1="1488" />
            <wire x2="1616" y1="2224" y2="2224" x1="1488" />
        </branch>
        <branch name="tsop1">
            <wire x2="1616" y1="672" y2="672" x1="1168" />
        </branch>
        <branch name="tsop2">
            <wire x2="1616" y1="896" y2="896" x1="1168" />
        </branch>
        <branch name="tsop3">
            <wire x2="1616" y1="1120" y2="1120" x1="1168" />
        </branch>
        <branch name="tsop4">
            <wire x2="1616" y1="1328" y2="1328" x1="1168" />
        </branch>
        <branch name="tsop5">
            <wire x2="1616" y1="1536" y2="1536" x1="1168" />
        </branch>
        <branch name="tsop6">
            <wire x2="1616" y1="1744" y2="1744" x1="1168" />
        </branch>
        <branch name="tsop7">
            <wire x2="1616" y1="1952" y2="1952" x1="1168" />
        </branch>
        <branch name="tsop8">
            <wire x2="1616" y1="2160" y2="2160" x1="1168" />
        </branch>
        <branch name="Res_TSOP4">
            <wire x2="2016" y1="1264" y2="1264" x1="2000" />
            <wire x2="2016" y1="1264" y2="1328" x1="2016" />
            <wire x2="2368" y1="1328" y2="1328" x1="2016" />
        </branch>
        <branch name="Res_TSOP5">
            <wire x2="2016" y1="1472" y2="1472" x1="2000" />
            <wire x2="2368" y1="1392" y2="1392" x1="2016" />
            <wire x2="2016" y1="1392" y2="1472" x1="2016" />
        </branch>
        <instance x="1616" y="768" name="XLXI_1" orien="R0">
        </instance>
        <iomarker fontsize="28" x="1168" y="672" name="tsop1" orien="R180" />
        <iomarker fontsize="28" x="1168" y="896" name="tsop2" orien="R180" />
        <iomarker fontsize="28" x="1168" y="1120" name="tsop3" orien="R180" />
        <iomarker fontsize="28" x="1168" y="1328" name="tsop4" orien="R180" />
        <iomarker fontsize="28" x="1168" y="1536" name="tsop5" orien="R180" />
        <iomarker fontsize="28" x="1168" y="1744" name="tsop6" orien="R180" />
        <iomarker fontsize="28" x="1168" y="1952" name="tsop7" orien="R180" />
        <iomarker fontsize="28" x="1168" y="2160" name="tsop8" orien="R180" />
        <instance x="800" y="464" name="XLXI_28" orien="R0">
        </instance>
        <branch name="HorlogeFPGA">
            <wire x2="800" y1="432" y2="432" x1="768" />
        </branch>
        <iomarker fontsize="28" x="768" y="432" name="HorlogeFPGA" orien="R180" />
        <branch name="XLXN_7">
            <wire x2="1584" y1="432" y2="432" x1="1184" />
            <wire x2="1584" y1="432" y2="608" x1="1584" />
            <wire x2="1616" y1="608" y2="608" x1="1584" />
            <wire x2="1584" y1="608" y2="832" x1="1584" />
            <wire x2="1616" y1="832" y2="832" x1="1584" />
            <wire x2="1584" y1="832" y2="1056" x1="1584" />
            <wire x2="1616" y1="1056" y2="1056" x1="1584" />
            <wire x2="1584" y1="1056" y2="1264" x1="1584" />
            <wire x2="1616" y1="1264" y2="1264" x1="1584" />
            <wire x2="1584" y1="1264" y2="1472" x1="1584" />
            <wire x2="1616" y1="1472" y2="1472" x1="1584" />
            <wire x2="1584" y1="1472" y2="1680" x1="1584" />
            <wire x2="1616" y1="1680" y2="1680" x1="1584" />
            <wire x2="1584" y1="1680" y2="1888" x1="1584" />
            <wire x2="1616" y1="1888" y2="1888" x1="1584" />
            <wire x2="1584" y1="1888" y2="2096" x1="1584" />
            <wire x2="1616" y1="2096" y2="2096" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="2368" y="1136" name="Res_TSOP1" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1200" name="Res_TSOP2" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1264" name="Res_TSOP3" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1328" name="Res_TSOP4" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1392" name="Res_TSOP5" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1456" name="Res_TSOP6" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1520" name="Res_TSOP7" orien="R0" />
        <iomarker fontsize="28" x="2368" y="1584" name="Res_TSOP8" orien="R0" />
    </sheet>
</drawing>