<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3a" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_15(11:0)" />
        <signal name="XLXN_31" />
        <signal name="XLXN_32" />
        <signal name="XLXN_33" />
        <signal name="XLXN_36" />
        <signal name="XLXN_37" />
        <signal name="XLXN_38" />
        <signal name="XLXN_34" />
        <signal name="XLXN_35" />
        <signal name="TSOP(7:0)" />
        <signal name="EtatCapteur(7:0)" />
        <signal name="Clk100KHz" />
        <port polarity="Input" name="TSOP(7:0)" />
        <port polarity="Output" name="EtatCapteur(7:0)" />
        <port polarity="Input" name="Clk100KHz" />
        <blockdef name="decod53200">
            <timestamp>2011-3-10T19:5:26</timestamp>
            <rect width="336" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
        </blockdef>
        <blockdef name="VectCaptVersCapts">
            <timestamp>2011-3-10T18:57:16</timestamp>
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="384" y1="160" y2="160" x1="320" />
            <line x2="384" y1="224" y2="224" x1="320" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-256" height="512" />
        </blockdef>
        <blockdef name="CaptsVersVectCapt">
            <timestamp>2011-3-10T18:58:36</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="256" x="64" y="-256" height="512" />
        </blockdef>
        <blockdef name="constant">
            <timestamp>2006-1-1T10:10:10</timestamp>
            <rect width="112" x="0" y="0" height="64" />
            <line x2="112" y1="32" y2="32" x1="144" />
        </blockdef>
        <block symbolname="decod53200" name="XLXI_1">
            <blockpin signalname="XLXN_1" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_31" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_2">
            <blockpin signalname="XLXN_2" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_32" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_3">
            <blockpin signalname="XLXN_3" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_33" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_4">
            <blockpin signalname="XLXN_4" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_34" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_5">
            <blockpin signalname="XLXN_5" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_35" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_6">
            <blockpin signalname="XLXN_6" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_36" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_8">
            <blockpin signalname="XLXN_8" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_38" name="capt" />
        </block>
        <block symbolname="decod53200" name="XLXI_7">
            <blockpin signalname="XLXN_7" name="tsop" />
            <blockpin signalname="Clk100KHz" name="H100KHz" />
            <blockpin signalname="XLXN_15(11:0)" name="code53200(11:0)" />
            <blockpin signalname="XLXN_37" name="capt" />
        </block>
        <block symbolname="VectCaptVersCapts" name="XLXI_9">
            <blockpin signalname="TSOP(7:0)" name="VectCapt(7:0)" />
            <blockpin signalname="XLXN_1" name="Capt0" />
            <blockpin signalname="XLXN_2" name="Capt1" />
            <blockpin signalname="XLXN_3" name="Capt2" />
            <blockpin signalname="XLXN_4" name="Capt3" />
            <blockpin signalname="XLXN_5" name="Capt4" />
            <blockpin signalname="XLXN_6" name="Capt5" />
            <blockpin signalname="XLXN_7" name="Capt6" />
            <blockpin signalname="XLXN_8" name="Capt7" />
        </block>
        <block symbolname="constant" name="XLXI_11">
            <attr value="005" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_15(11:0)" name="O" />
        </block>
        <block symbolname="CaptsVersVectCapt" name="XLXI_10">
            <blockpin signalname="XLXN_31" name="Capt0" />
            <blockpin signalname="XLXN_32" name="Capt1" />
            <blockpin signalname="XLXN_33" name="Capt2" />
            <blockpin signalname="XLXN_34" name="Capt3" />
            <blockpin signalname="EtatCapteur(7:0)" name="VectCapt(7:0)" />
            <blockpin signalname="XLXN_35" name="Capt4" />
            <blockpin signalname="XLXN_36" name="Capt5" />
            <blockpin signalname="XLXN_37" name="Capt6" />
            <blockpin signalname="XLXN_38" name="Capt7" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3801" height="2688">
        <attr value="CM" name="LengthUnitName" />
        <attr value="4" name="GridsPerUnit" />
        <instance x="1728" y="448" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1728" y="736" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1728" y="1024" name="XLXI_3" orien="R0">
        </instance>
        <instance x="1728" y="1312" name="XLXI_4" orien="R0">
        </instance>
        <instance x="1728" y="1616" name="XLXI_5" orien="R0">
        </instance>
        <instance x="1728" y="1920" name="XLXI_6" orien="R0">
        </instance>
        <instance x="1728" y="2528" name="XLXI_8" orien="R0">
        </instance>
        <instance x="1728" y="2224" name="XLXI_7" orien="R0">
        </instance>
        <branch name="XLXN_4">
            <wire x2="1104" y1="1280" y2="1280" x1="896" />
            <wire x2="1104" y1="1152" y2="1280" x1="1104" />
            <wire x2="1728" y1="1152" y2="1152" x1="1104" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1104" y1="1344" y2="1344" x1="896" />
            <wire x2="1104" y1="1344" y2="1456" x1="1104" />
            <wire x2="1728" y1="1456" y2="1456" x1="1104" />
        </branch>
        <instance x="512" y="1312" name="XLXI_9" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="960" y1="1088" y2="1088" x1="896" />
            <wire x2="960" y1="288" y2="1088" x1="960" />
            <wire x2="1728" y1="288" y2="288" x1="960" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1008" y1="1152" y2="1152" x1="896" />
            <wire x2="1008" y1="576" y2="1152" x1="1008" />
            <wire x2="1728" y1="576" y2="576" x1="1008" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1056" y1="1216" y2="1216" x1="896" />
            <wire x2="1056" y1="864" y2="1216" x1="1056" />
            <wire x2="1728" y1="864" y2="864" x1="1056" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="1056" y1="1408" y2="1408" x1="896" />
            <wire x2="1056" y1="1408" y2="1760" x1="1056" />
            <wire x2="1728" y1="1760" y2="1760" x1="1056" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="1008" y1="1472" y2="1472" x1="896" />
            <wire x2="1008" y1="1472" y2="2064" x1="1008" />
            <wire x2="1728" y1="2064" y2="2064" x1="1008" />
        </branch>
        <branch name="XLXN_8">
            <wire x2="960" y1="1536" y2="1536" x1="896" />
            <wire x2="960" y1="1536" y2="2368" x1="960" />
            <wire x2="1728" y1="2368" y2="2368" x1="960" />
        </branch>
        <branch name="XLXN_15(11:0)">
            <wire x2="1568" y1="2608" y2="2608" x1="1232" />
            <wire x2="1728" y1="416" y2="416" x1="1568" />
            <wire x2="1568" y1="416" y2="704" x1="1568" />
            <wire x2="1728" y1="704" y2="704" x1="1568" />
            <wire x2="1568" y1="704" y2="992" x1="1568" />
            <wire x2="1728" y1="992" y2="992" x1="1568" />
            <wire x2="1568" y1="992" y2="1280" x1="1568" />
            <wire x2="1728" y1="1280" y2="1280" x1="1568" />
            <wire x2="1568" y1="1280" y2="1584" x1="1568" />
            <wire x2="1728" y1="1584" y2="1584" x1="1568" />
            <wire x2="1568" y1="1584" y2="1888" x1="1568" />
            <wire x2="1728" y1="1888" y2="1888" x1="1568" />
            <wire x2="1568" y1="1888" y2="2192" x1="1568" />
            <wire x2="1728" y1="2192" y2="2192" x1="1568" />
            <wire x2="1568" y1="2192" y2="2496" x1="1568" />
            <wire x2="1728" y1="2496" y2="2496" x1="1568" />
            <wire x2="1568" y1="2496" y2="2608" x1="1568" />
        </branch>
        <instance x="1088" y="2576" name="XLXI_11" orien="R0">
        </instance>
        <branch name="XLXN_31">
            <wire x2="2960" y1="288" y2="288" x1="2192" />
            <wire x2="2960" y1="288" y2="1088" x1="2960" />
            <wire x2="3024" y1="1088" y2="1088" x1="2960" />
        </branch>
        <branch name="XLXN_32">
            <wire x2="2912" y1="576" y2="576" x1="2192" />
            <wire x2="2912" y1="576" y2="1152" x1="2912" />
            <wire x2="3024" y1="1152" y2="1152" x1="2912" />
        </branch>
        <branch name="XLXN_33">
            <wire x2="2864" y1="864" y2="864" x1="2192" />
            <wire x2="2864" y1="864" y2="1216" x1="2864" />
            <wire x2="3024" y1="1216" y2="1216" x1="2864" />
        </branch>
        <branch name="XLXN_36">
            <wire x2="2864" y1="1760" y2="1760" x1="2192" />
            <wire x2="3024" y1="1408" y2="1408" x1="2864" />
            <wire x2="2864" y1="1408" y2="1760" x1="2864" />
        </branch>
        <branch name="XLXN_37">
            <wire x2="2912" y1="2064" y2="2064" x1="2192" />
            <wire x2="3024" y1="1472" y2="1472" x1="2912" />
            <wire x2="2912" y1="1472" y2="2064" x1="2912" />
        </branch>
        <branch name="XLXN_38">
            <wire x2="2960" y1="2368" y2="2368" x1="2192" />
            <wire x2="3024" y1="1536" y2="1536" x1="2960" />
            <wire x2="2960" y1="1536" y2="2368" x1="2960" />
        </branch>
        <branch name="TSOP(7:0)">
            <wire x2="512" y1="1088" y2="1088" x1="432" />
        </branch>
        <branch name="EtatCapteur(7:0)">
            <wire x2="3424" y1="1088" y2="1088" x1="3408" />
            <wire x2="3472" y1="1088" y2="1088" x1="3424" />
        </branch>
        <iomarker fontsize="28" x="432" y="1088" name="TSOP(7:0)" orien="R180" />
        <instance x="3024" y="1312" name="XLXI_10" orien="R0">
        </instance>
        <branch name="XLXN_34">
            <wire x2="2816" y1="1152" y2="1152" x1="2192" />
            <wire x2="2816" y1="1152" y2="1280" x1="2816" />
            <wire x2="3024" y1="1280" y2="1280" x1="2816" />
        </branch>
        <branch name="XLXN_35">
            <wire x2="2816" y1="1456" y2="1456" x1="2192" />
            <wire x2="3024" y1="1344" y2="1344" x1="2816" />
            <wire x2="2816" y1="1344" y2="1456" x1="2816" />
        </branch>
        <iomarker fontsize="28" x="3472" y="1088" name="EtatCapteur(7:0)" orien="R0" />
        <branch name="Clk100KHz">
            <wire x2="1664" y1="144" y2="144" x1="864" />
            <wire x2="1664" y1="144" y2="352" x1="1664" />
            <wire x2="1728" y1="352" y2="352" x1="1664" />
            <wire x2="1664" y1="352" y2="640" x1="1664" />
            <wire x2="1728" y1="640" y2="640" x1="1664" />
            <wire x2="1664" y1="640" y2="928" x1="1664" />
            <wire x2="1728" y1="928" y2="928" x1="1664" />
            <wire x2="1664" y1="928" y2="1216" x1="1664" />
            <wire x2="1728" y1="1216" y2="1216" x1="1664" />
            <wire x2="1664" y1="1216" y2="1520" x1="1664" />
            <wire x2="1728" y1="1520" y2="1520" x1="1664" />
            <wire x2="1664" y1="1520" y2="1824" x1="1664" />
            <wire x2="1728" y1="1824" y2="1824" x1="1664" />
            <wire x2="1664" y1="1824" y2="2128" x1="1664" />
            <wire x2="1728" y1="2128" y2="2128" x1="1664" />
            <wire x2="1664" y1="2128" y2="2432" x1="1664" />
            <wire x2="1728" y1="2432" y2="2432" x1="1664" />
        </branch>
        <iomarker fontsize="28" x="864" y="144" name="Clk100KHz" orien="R180" />
    </sheet>
</drawing>