----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:50:20 04/14/2011 
-- Design Name: 
-- Module Name:    Debut_Fin_Course - Behavioral 
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

entity Debut_Fin_Course is
    Port ( Jack : in  STD_LOGIC;
           LEDrouge : out  STD_LOGIC;
           LEDverte : out  STD_LOGIC;
           FinCourse : in  STD_LOGIC;
			  Clk10Hz : in  STD_LOGIC;
			  MemoFinCourse: out std_logic;
           SignalMoteur : out  STD_LOGIC_VECTOR (3 downto 0));
end Debut_Fin_Course;

architecture Behavioral of Debut_Fin_Course is
signal timer : integer range 0 to 32;
signal CptFinCourse : integer range 0 to 8;
signal CptLED : integer range 0 to 8;

begin
process(Clk10Hz)
begin
	if Clk10Hz'event and Clk10Hz = '1' then
		if Jack = '1' then
--			Timer avant prise en compte du capteur fin de course 3s
			if timer < 32 then timer <= timer + 1; end if; 
			if Fincourse = '0' and Timer > 30 then
--				CptFinCourse : delay apres detection fin course 0.5s
				if CptFinCourse < 8 then CptFinCourse <= CptFinCourse + 1; end if;
				if CptFinCourse > 5 then MemoFinCourse <= '1';
--					CptLED : delay apres l'arret des moteur 0.5s
					if CptLED < 8 then CptLED <= CptLED + 1; end if;
				end if;
				if CptLED > 5 then LEDverte <= '1'; LEDrouge <= '0'; end if;
			else CptFinCourse <= 0; end if; 
		end if;
		if Jack = '0' then 
			timer <= 0; CptLED <=0; CptFinCourse <= 0; 
			LEDverte <= '0'; LEDrouge <= '1'; 
			MemoFinCourse <= '0';
		end if;
	end if;
	SignalMoteur <= "0000";
end process;
end Behavioral;

