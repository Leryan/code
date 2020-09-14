----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:52 02/09/2011 
-- Design Name: 
-- Module Name:    decod53200 - Behavioral 
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

entity decod53200 is
    Port ( tsop : in  STD_LOGIC;
           H100KHz : in  STD_LOGIC;
           code53200 : in  STD_LOGIC_VECTOR (11 downto 0);
           capt : out  STD_LOGIC);
end decod53200;

architecture Behavioral of decod53200 is
signal code: STD_LOGIC_VECTOR (11 downto 0);
signal numBit: integer range 0 to 12;
signal Cpt: integer range 0 to 255;
signal TimeAout: integer range 0 to 40000;
begin
	process (H100KHz)
	begin
		if H100KHz'event and H100KHz = '1' then
		TimeAout <= TimeAout +1;
			if tsop = '1' and cpt > 140 then	cpt <= 0;
			else
			if cpt < 250 then
				if (tsop = '0' or cpt > 0 ) then cpt <= cpt + 1; end if;
			end if;
			end if;
			if cpt = 104 and numBit < 12 then code(11 - numBit) <= not tsop; numBit <= numBit + 1; end if;
		end if;
		if cpt >= 250 then numbit <= 0; end if;
		if numBit = 12 then
			if code53200 = code then capt <= '1';
			else capt <= '0';
			end if;
		end if;
		if tsop = '1' then TimeAout <= 0; end if;
		if TimeAout = 35000 then capt <= '0'; end if;
	end process;
end Behavioral;

