----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:00 03/09/2011 
-- Design Name: 
-- Module Name:    correcteurBalise - Behavioral 
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

entity correcteurBalise is
    Port ( D_G : in  STD_LOGIC;
           defaut : in  STD_LOGIC;
           ecart : in  STD_LOGIC_VECTOR (2 downto 0);
           vitesseMli : in  STD_LOGIC_VECTOR (15 downto 0);
			  inGpGmDpDm : out  STD_LOGIC_VECTOR (3 downto 0));
end correcteurBalise;

architecture Behavioral of correcteurBalise is

begin
	process
	begin
		if defaut = '0' then
			if D_G = '0' then
				if ecart = "001" then inGpGmDpDm(1) <= vitesseMli(13); inGpGmDpDm(3) <= vitesseMli(11); end if;
				if ecart = "010" then inGpGmDpDm(1) <= vitesseMli(13); inGpGmDpDm(3) <= vitesseMli(10); end if;
				if ecart = "011" then inGpGmDpDm(1) <= vitesseMli(13); inGpGmDpDm(3) <= vitesseMli(9); end if;
				if ecart = "100" then inGpGmDpDm(1) <= vitesseMli(13); inGpGmDpDm(3) <= vitesseMli(7); end if;
			end if;		
			if D_G = '1' then
				if ecart = "000" then inGpGmDpDm(1) <= vitesseMli(13); inGpGmDpDm(3) <= vitesseMli(13); end if;
				if ecart = "001" then inGpGmDpDm(1) <= vitesseMli(11); inGpGmDpDm(3) <= vitesseMli(13); end if;
				if ecart = "010" then inGpGmDpDm(1) <= vitesseMli(10); inGpGmDpDm(3) <= vitesseMli(13); end if;
				if ecart = "011" then inGpGmDpDm(1) <= vitesseMli(9);  inGpGmDpDm(3) <= vitesseMli(13); end if;
				if ecart = "100" then inGpGmDpDm(1) <= vitesseMli(7);  inGpGmDpDm(3) <= vitesseMli(13); end if;
			end if;			
		else inGpGmDpDm(1) <= vitesseMli(3); inGpGmDpDm(3) <= vitesseMli(9); end if;
		inGpGmDpDm(0) <= '0';
		inGpGmDpDm(2) <= '0';
	end process;
end Behavioral;

