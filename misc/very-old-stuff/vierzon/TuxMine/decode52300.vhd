----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:00:17 02/09/2011 
-- Design Name: 
-- Module Name:    Decodeur_VHDL - Behavioral 
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


entity decod53200 is
    Port ( clkDec53200 : in  STD_LOGIC;
				code53200 : in  STD_LOGIC_VECTOR (11 downto 0);
				tsop : in  STD_LOGIC;
				capt : out  STD_LOGIC);
end decod53200;

architecture Behavioral of decod53200 is
constant demiTbit : integer := 104;
constant Tbit : integer :=2 * demiTbit;
constant timeout : integer :=2 * Tbit;
signal cptTimeout : integer range 0 to 2 * Tbit;
signal cptNumbit : integer range 0 to 12;
signal cptBit : integer range 0 to Tbit;
signal trame : STD_LOGIC_VECTOR (11 downto 0);

begin
process (clkDEc53200)
	begin 
		if clkDEc53200'event and clkDEc53200='1' then 
		   --incrementation compteurs
			if cptTimeout < timeout then cptTimeout <= cptTimeout+1; end if;
			if ((cptBit = demiTbit)and (cptNumbit<12)) then cptNumbit <= cptNumbit + 1; end if;			
			if cptBit < Tbit then cptBit <= cptBit +1; end if;			
			--reset compteurs ... ECRASE INCREMENTATION PLACEE AU DESSUS
			if tsop='1' then 	cptTimeout <= 0;  end if;
			if cptTimeout = timeout then cptNumbit <=0; end if;
			if cptTimeout=1 then  cptBit <= 0; end if;
			--CAPTURE tsop
			if ((cptBit = demiTbit)and (cptNumbit<12))	then 
				trame(cptNumbit) <= not tsop;
			end if;
		end if;
	end process;
	capt<='1' when (trame=code53200) else '0';
end Behavioral;