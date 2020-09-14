----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:36:54 03/09/2011 
-- Design Name: 
-- Module Name:    DiviseurDeFrquence10KHz - Behavioral 
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

entity DiviseurDeFrquence10KHz is
    Port ( Clk100KHz : in  STD_LOGIC;
           Clk10KHz : inout  STD_LOGIC);
end DiviseurDeFrquence10KHz;

architecture Behavioral of DiviseurDeFrquence10KHz is
signal Cpt : integer range 0 to 8;

begin
process (Clk100KHz)
begin
	if Clk100KHz'event and Clk100KHz = '1' then
		Cpt <= Cpt + 1;
		if Cpt = 5 then Clk10KHz <= not Clk10KHz; Cpt <= 0 ; end if;
	end if;
end process;
end Behavioral;

