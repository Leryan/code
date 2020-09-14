----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:22 03/09/2011 
-- Design Name: 
-- Module Name:    calculeEcartBalise - Behavioral 
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

entity calculeEcartBalise is
    Port ( CaptTsop : in  STD_LOGIC_VECTOR (7 downto 0);
           D_G : out  STD_LOGIC;
           defaut : out  STD_LOGIC;
           ecart : out  STD_LOGIC_VECTOR (2 downto 0));
end calculeEcartBalise;

architecture Behavioral of calculeEcartBalise is

begin

D_G <=		'1' when CaptTsop = "10000111" else
				'1' when CaptTsop = "00000011" else
				'1' when CaptTsop = "10001111" else
				'1' when CaptTsop = "00000111" else
				'1' when CaptTsop = "00000010" else
				'1' when CaptTsop = "00001111" else
				'1' when CaptTsop = "00000110" else
				'1' when CaptTsop = "00011111" else
				'1' when CaptTsop = "00001110" else
				'1' when CaptTsop = "00000100" else
				'1' when CaptTsop = "11000111" else
				'1' when CaptTsop = "10000011" else
				'1' when CaptTsop = "00000001" else
				'0';
				
ecart <=		"000" when CaptTsop = "11000111" else
				"000" when CaptTsop = "10000011" else
				"000" when CaptTsop = "00000001" else
				"001" when CaptTsop = "11000011" else
				"001" when CaptTsop = "10000001" else
				"001" when CaptTsop = "10000111" else
				"001" when CaptTsop = "00000011" else
				"010" when CaptTsop = "11100011" else
				"010" when CaptTsop = "11000001" else
				"010" when CaptTsop = "10000000" else
				"010" when CaptTsop = "10001111" else
				"010" when CaptTsop = "00000111" else
				"010" when CaptTsop = "00000010" else
				"011" when CaptTsop = "11100001" else
				"011" when CaptTsop = "11000000" else
				"011" when CaptTsop = "00001111" else
				"011" when CaptTsop = "00000110" else
				"100" when CaptTsop = "11110001" else
				"100" when CaptTsop = "11100000" else
				"100" when CaptTsop = "01000000" else
				"100" when CaptTsop = "00011111" else
				"100" when CaptTsop = "00001110" else
				"100" when CaptTsop = "00000100" else
				"111";

defaut <=	'0' when CaptTsop = "11000111" else
				'0' when CaptTsop = "10000011" else
				'0' when CaptTsop = "00000001" else
				'0' when CaptTsop = "11000011" else
				'0' when CaptTsop = "10000001" else
				'0' when CaptTsop = "10000111" else
				'0' when CaptTsop = "00000011" else
				'0' when CaptTsop = "11100011" else
				'0' when CaptTsop = "11000001" else
				'0' when CaptTsop = "10000000" else
				'0' when CaptTsop = "10001111" else
				'0' when CaptTsop = "00000111" else
				'0' when CaptTsop = "00000010" else
				'0' when CaptTsop = "11100001" else
				'0' when CaptTsop = "11000000" else
				'0' when CaptTsop = "00001111" else
				'0' when CaptTsop = "00000110" else
				'0' when CaptTsop = "11110001" else
				'0' when CaptTsop = "11100000" else
				'0' when CaptTsop = "01000000" else
				'0' when CaptTsop = "00011111" else
				'0' when CaptTsop = "00001110" else
				'0' when CaptTsop = "00000100" else
				'1';
end Behavioral;

