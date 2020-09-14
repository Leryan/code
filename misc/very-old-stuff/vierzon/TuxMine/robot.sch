<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="MccG" />
        <signal name="MccD" />
        <signal name="XLXN_38(0:7)" />
        <signal name="XLXN_39" />
        <signal name="XLXN_40" />
        <signal name="XLXN_41" />
        <signal name="XLXN_42" />
        <signal name="XLXN_43" />
        <signal name="XLXN_44" />
        <signal name="XLXN_45" />
        <signal name="XLXN_46" />
        <signal name="tsop1" />
        <signal name="tsop2" />
        <signal name="tsop3" />
        <signal name="tsop4" />
        <signal name="tsop5" />
        <signal name="tsop6" />
        <signal name="tsop7" />
        <signal name="tsop8" />
        <signal name="H100KHz" />
        <signal name="XLXN_59(0:100)" />
        <signal name="Clk28MHz" />
        <port polarity="Output" name="MccG" />
        <port polarity="Output" name="MccD" />
        <port polarity="Input" name="tsop1" />
        <port polarity="Input" name="tsop2" />
        <port polarity="Input" name="tsop3" />
        <port polarity="Input" name="tsop4" />
        <port polarity="Input" name="tsop5" />
        <port polarity="Input" name="tsop6" />
        <port polarity="Input" name="tsop7" />
        <port polarity="Input" name="tsop8" />
        <port polarity="Input" name="Clk28MHz" />
        <blockdef name="Clk28MHzTo100KHz">
            <timestamp>2011-5-29T19:8:48</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="paraToBus8">
            <timestamp>2011-5-29T19:8:44</timestamp>
            <rect width="256" x="64" y="-512" height="512" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-492" height="24" />
            <line x2="384" y1="-480" y2="-480" x1="320" />
        </blockdef>
        <blockdef name="mli">
            <timestamp>2011-5-29T19:8:54</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="ecart_tsop">
            <timestamp>2011-5-29T19:11:3</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
        </blockdef>
        <blockdef name="tsop_8">
            <timestamp>2011-5-29T19:15:43</timestamp>
            <rect width="288" x="64" y="-576" height="576" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="416" y1="-544" y2="-544" x1="352" />
            <line x2="416" y1="-480" y2="-480" x1="352" />
            <line x2="416" y1="-416" y2="-416" x1="352" />
            <line x2="416" y1="-352" y2="-352" x1="352" />
            <line x2="416" y1="-288" y2="-288" x1="352" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
            <line x2="416" y1="-160" y2="-160" x1="352" />
            <line x2="416" y1="-96" y2="-96" x1="352" />
        </blockdef>
        <block symbolname="paraToBus8" name="XLXI_11">
            <blockpin signalname="XLXN_39" name="tsop1" />
            <blockpin signalname="XLXN_40" name="tsop2" />
            <blockpin signalname="XLXN_41" name="tsop3" />
            <blockpin signalname="XLXN_42" name="tsop4" />
            <blockpin signalname="XLXN_43" name="tsop5" />
            <blockpin signalname="XLXN_44" name="tsop6" />
            <blockpin signalname="XLXN_45" name="tsop7" />
            <blockpin signalname="XLXN_46" name="tsop8" />
            <blockpin signalname="XLXN_38(0:7)" name="TSOP(0:7)" />
        </block>
        <block symbolname="mli" name="XLXI_15">
            <blockpin signalname="H100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_59(0:100)" name="OutMLI(0:100)" />
        </block>
        <block symbolname="ecart_tsop" name="XLXI_16">
            <blockpin signalname="MccG" name="mliG" />
            <blockpin signalname="MccD" name="mliD" />
            <blockpin signalname="XLXN_59(0:100)" name="MLI(0:100)" />
            <blockpin signalname="XLXN_38(0:7)" name="tsop(0:7)" />
        </block>
        <block symbolname="tsop_8" name="XLXI_17">
            <blockpin signalname="tsop1" name="tsop1" />
            <blockpin signalname="tsop2" name="tsop2" />
            <blockpin signalname="tsop3" name="tsop3" />
            <blockpin signalname="tsop4" name="tsop4" />
            <blockpin signalname="tsop5" name="tsop5" />
            <blockpin signalname="tsop6" name="tsop6" />
            <blockpin signalname="tsop7" name="tsop7" />
            <blockpin signalname="tsop8" name="tsop8" />
            <blockpin signalname="H100KHz" name="HorlogeFPGA" />
            <blockpin signalname="XLXN_39" name="Res_TSOP1" />
            <blockpin signalname="XLXN_40" name="Res_TSOP2" />
            <blockpin signalname="XLXN_41" name="Res_TSOP3" />
            <blockpin signalname="XLXN_42" name="Res_TSOP6" />
            <blockpin signalname="XLXN_43" name="Res_TSOP7" />
            <blockpin signalname="XLXN_44" name="Res_TSOP8" />
            <blockpin signalname="XLXN_45" name="Res_TSOP4" />
            <blockpin signalname="XLXN_46" name="Res_TSOP5" />
        </block>
        <block symbolname="Clk28MHzTo100KHz" name="XLXI_9">
            <blockpin signalname="Clk28MHz" name="Clk28MHz" />
            <blockpin signalname="H100KHz" name="Clk100KHz" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2096" y="1680" name="XLXI_11" orien="R0">
        </instance>
        <instance x="2672" y="1232" name="XLXI_16" orien="R0">
        </instance>
        <branch name="MccG">
            <wire x2="3088" y1="1136" y2="1136" x1="3056" />
        </branch>
        <branch name="MccD">
            <wire x2="3088" y1="1200" y2="1200" x1="3056" />
        </branch>
        <branch name="XLXN_38(0:7)">
            <wire x2="2672" y1="1200" y2="1200" x1="2480" />
        </branch>
        <iomarker fontsize="28" x="3088" y="1136" name="MccG" orien="R0" />
        <iomarker fontsize="28" x="3088" y="1200" name="MccD" orien="R0" />
        <instance x="1600" y="1744" name="XLXI_17" orien="R0">
        </instance>
        <branch name="XLXN_39">
            <wire x2="2096" y1="1200" y2="1200" x1="2016" />
        </branch>
        <branch name="XLXN_40">
            <wire x2="2096" y1="1264" y2="1264" x1="2016" />
        </branch>
        <branch name="XLXN_41">
            <wire x2="2096" y1="1328" y2="1328" x1="2016" />
        </branch>
        <branch name="XLXN_42">
            <wire x2="2096" y1="1392" y2="1392" x1="2016" />
        </branch>
        <branch name="XLXN_43">
            <wire x2="2096" y1="1456" y2="1456" x1="2016" />
        </branch>
        <branch name="XLXN_44">
            <wire x2="2096" y1="1520" y2="1520" x1="2016" />
        </branch>
        <branch name="XLXN_45">
            <wire x2="2096" y1="1584" y2="1584" x1="2016" />
        </branch>
        <branch name="XLXN_46">
            <wire x2="2096" y1="1648" y2="1648" x1="2016" />
        </branch>
        <branch name="tsop1">
            <wire x2="1600" y1="1200" y2="1200" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1200" name="tsop1" orien="R180" />
        <branch name="tsop2">
            <wire x2="1600" y1="1264" y2="1264" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1264" name="tsop2" orien="R180" />
        <branch name="tsop3">
            <wire x2="1600" y1="1328" y2="1328" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1328" name="tsop3" orien="R180" />
        <branch name="tsop4">
            <wire x2="1600" y1="1392" y2="1392" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1392" name="tsop4" orien="R180" />
        <branch name="tsop5">
            <wire x2="1600" y1="1456" y2="1456" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1456" name="tsop5" orien="R180" />
        <branch name="tsop6">
            <wire x2="1600" y1="1520" y2="1520" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1520" name="tsop6" orien="R180" />
        <branch name="tsop7">
            <wire x2="1600" y1="1584" y2="1584" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1584" name="tsop7" orien="R180" />
        <branch name="tsop8">
            <wire x2="1600" y1="1648" y2="1648" x1="1568" />
        </branch>
        <iomarker fontsize="28" x="1568" y="1648" name="tsop8" orien="R180" />
        <branch name="XLXN_59(0:100)">
            <wire x2="2656" y1="1024" y2="1024" x1="2208" />
            <wire x2="2656" y1="1024" y2="1136" x1="2656" />
            <wire x2="2672" y1="1136" y2="1136" x1="2656" />
        </branch>
        <instance x="1824" y="1056" name="XLXI_15" orien="R0">
        </instance>
        <branch name="Clk28MHz">
            <wire x2="848" y1="1024" y2="1024" x1="816" />
        </branch>
        <instance x="848" y="1056" name="XLXI_9" orien="R0">
        </instance>
        <iomarker fontsize="28" x="816" y="1024" name="Clk28MHz" orien="R180" />
        <branch name="H100KHz">
            <wire x2="1392" y1="1024" y2="1024" x1="1232" />
            <wire x2="1392" y1="1024" y2="1712" x1="1392" />
            <wire x2="1600" y1="1712" y2="1712" x1="1392" />
            <wire x2="1824" y1="1024" y2="1024" x1="1392" />
        </branch>
    </sheet>
</drawing>