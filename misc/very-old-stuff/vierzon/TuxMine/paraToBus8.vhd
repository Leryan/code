----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:52 03/31/2011 
-- Design Name: 
-- Module Name:    paraToBus8 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity paraToBus8 is
    Port ( tsop1 : in  STD_LOGIC;
           tsop2 : in  STD_LOGIC;
           tsop3 : in  STD_LOGIC;
           tsop4 : in  STD_LOGIC;
           tsop5 : in  STD_LOGIC;
           tsop6 : in  STD_LOGIC;
           tsop7 : in  STD_LOGIC;
           tsop8 : in  STD_LOGIC;
           TSOP : out  STD_LOGIC_VECTOR (0 to 7));
end paraToBus8;

architecture Behavioral of paraToBus8 is
begin

	TSOP(0) <= tsop1; --Devant
	TSOP(1) <= tsop2; --A droite
	TSOP(2) <= tsop3;
	TSOP(3) <= tsop4;
	TSOP(4) <= tsop5;
	TSOP(5) <= tsop6;
	TSOP(6) <= tsop7;
	TSOP(7) <= tsop8; --A gauche

end Behavioral;

