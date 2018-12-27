----------------------------------------------------------------------------------
-- Company: GEII
-- Engineer: Alips/Ligerot
-- 
-- Create Date:    14:51:37 02/04/2011 
-- Design Name: 
-- Module Name:    SignalMli - Behavioral 
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


entity SignalMli is
    Port ( H10kHz : in  STD_LOGIC;
           VecteurMli : out  STD_LOGIC_VECTOR (15 downto 0));
end SignalMli;

architecture Behavioral of SignalMli is
signal Cpt: integer range 0 to 15;
begin

	process (H10kHz)

	begin
		if H10kHz'event and H10kHz = '1' then Cpt <= Cpt + 1;
			if Cpt = 15 then Cpt <= 0; end if;
			if Cpt = 0 then VecteurMli <= "1111111111111110"; end if;
			if Cpt < 15 then VecteurMli(Cpt) <= '0'; end if;
		end if;
		
	end process;

end Behavioral;

