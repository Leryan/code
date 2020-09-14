----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:05:47 04/14/2011 
-- Design Name: 
-- Module Name:    DiviseurDeFrequence10Hz - Behavioral 
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

entity DiviseurDeFrequence10Hz is
    Port ( Clk10KHz : in  STD_LOGIC;
           Clk10Hz : inout  STD_LOGIC);
end DiviseurDeFrequence10Hz;

architecture Behavioral of DiviseurDeFrequence10Hz is
signal Cpt : integer range 0 to 600;

begin
process (Clk10KHz)
begin
	if Clk10KHz'event and Clk10KHz = '1' then
		Cpt <= Cpt + 1;
		if Cpt = 500 then Clk10Hz <= not Clk10Hz; Cpt <= 0 ; end if;
	end if;
end process;
end Behavioral;
