----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:57 02/23/2011 
-- Design Name: 
-- Module Name:    DiviseurDeFrequence - Behavioral 
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

entity DiviseurDeFrequence is
    Port ( Clk28MHz : in  STD_LOGIC;
           Clk100KHz : inout  STD_LOGIC);
end DiviseurDeFrequence;

architecture Behavioral of DiviseurDeFrequence is
signal Cpt : integer range 0 to 250;

begin
process (Clk28MHz)
begin
	if Clk28MHz'event and Clk28MHz = '1' then
		Cpt <= Cpt + 1;
		if Cpt = 140 then Clk100KHz <= not Clk100KHz; Cpt <= 0 ; end if;
	end if;
end process;
end Behavioral;

