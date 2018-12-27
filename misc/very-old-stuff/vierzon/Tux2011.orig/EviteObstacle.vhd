----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:44:44 04/14/2011 
-- Design Name: 
-- Module Name:    EviteObstacle - Behavioral 
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

entity EviteObstacle is
    Port ( defaut : in  STD_LOGIC;
			  CycleEvitement: inout STD_LOGIC;
           signalMoteur : out  STD_LOGIC_VECTOR (3 downto 0);
			  VecteurMli : in  STD_LOGIC_VECTOR (15 downto 0);
           Clk10KHz : in  STD_LOGIC;
           ObstacleD : in  STD_LOGIC;
			  ObstacleG : in  STD_LOGIC);
end EviteObstacle;

architecture Behavioral of EviteObstacle is
signal Cpt : integer range 0 to 32000;
signal Position : std_logic := '0';

begin
process(Clk10KHz)
begin
--	    Cycle d'evitement d'obstacle
	if Clk10KHz'event and Clk10KHz = '1' then
		if ObstacleD = '0' and CycleEvitement = '0' then CycleEvitement <= '1'; Position <= '0'; end if;
		if ObstacleG = '0' and CycleEvitement = '0' then CycleEvitement <= '1'; Position <= '1'; end if;
		if CycleEvitement = '1' then Cpt <= Cpt + 1; end if;
		if Cpt < 3000 then signalMoteur <= "0000"; end if;
--		pas de defaut
		if defaut = '0' then
--			balise a gauche du robot
			if Position = '1' then
--				marche arriere pendant 1s
				if Cpt > 3000 and Cpt < 14000 then 
					signalMoteur(0) <= VecteurMli(5);
					signalMoteur(1) <= '0';
					signalMoteur(2) <= VecteurMli(5);
					signalMoteur(3) <= '0';
				else
--					tourner a droite pendant 0.5s
					if Cpt < 19000 then 
						signalMoteur(0) <= VecteurMli(5);
						signalMoteur(1) <= '0';
						signalMoteur(2) <= '0';
						signalMoteur(3) <= '0';
					else
--						marche avant pendant 1s
						if Cpt > 20000 and Cpt < 31000 then 
							signalMoteur(0) <= '0';
							signalMoteur(1) <= VecteurMli(5);
							signalMoteur(2) <= '0';
							signalMoteur(3) <= VecteurMli(5);
						else
							if Cpt > 30000 then CycleEvitement <= '0'; cpt <= 0; end if;
						end if;
					end if;
				end if;
			end if;
--			balise a droite du robot
			if Position = '0' then 
--				marche arriere pendant 1s
				if Cpt > 3000 and Cpt < 14000 then 
					signalMoteur(0) <= VecteurMli(5);
					signalMoteur(1) <= '0';
					signalMoteur(2) <= VecteurMli(5);
					signalMoteur(3) <= '0';
				else
--					tourner a gauche pendant 0.5s
					if Cpt < 19000 then 
						signalMoteur(0) <= '0';
						signalMoteur(1) <= '0';
						signalMoteur(2) <= VecteurMli(5);
						signalMoteur(3) <= '0';
					else
--						marche avant pendant 1s
						if Cpt > 20000 and Cpt < 31000 then 
							signalMoteur(0) <= '0';
							signalMoteur(1) <= VecteurMli(5);
							signalMoteur(2) <= '0';
							signalMoteur(3) <= VecteurMli(5);
						else
							if Cpt > 30000 then CycleEvitement <= '0'; cpt <= 0; end if;
						end if;
					end if;
				end if;
			end if;
		end if;
--		robot en mode defaut
		if defaut = '1' then
--			marche arriere pendant 1s
			if Cpt > 3000 and Cpt < 14000 then 
				signalMoteur(0) <= VecteurMli(5);
				signalMoteur(1) <= '0';
				signalMoteur(2) <= VecteurMli(4);
				signalMoteur(3) <= '0';
			else
				if Cpt > 15000 then CycleEvitement <= '0'; cpt <= 0; end if;
			end if;
		end if;
	end if;
end process;
end Behavioral;

