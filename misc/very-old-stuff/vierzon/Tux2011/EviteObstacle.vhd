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
signal Position : std_logic;

begin
process(Clk10KHz)
begin

if Clk10KHz'event and Clk10KHz = '1' then
	if ObstacleD = '0' and CycleEvitement = '0' then CycleEvitement <= '1'; Position <= '0'; end if;
	if ObstacleG = '0' and CycleEvitement = '0' then CycleEvitement <= '1'; Position <= '1'; end if;
--	Cycle d'evitement d'obstacle
	if CycleEvitement = '1' then
		Cpt <= Cpt + 1;
		if Cpt < 1500 then
			signalMoteur <= "0000";
	--		marche arriere pendant 1s
		elsif Cpt >= 1500 and Cpt < 10000 then 
			signalMoteur(0) <= VecteurMli(6);
			signalMoteur(1) <= '0';
			signalMoteur(2) <= VecteurMli(6);
			signalMoteur(3) <= '0';
		elsif Cpt >= 10000 and Cpt < 14000 then --26 000
	--			tourner a droite pendant 0.5s
	--obstacle à gauche
			if Position = '1' then
				signalMoteur(0) <= VecteurMli(7); --moteur gauche
				signalMoteur(1) <= '0';
				signalMoteur(2) <= '0';
				signalMoteur(3) <= '0';
			else
				signalMoteur(0) <= '0';
				signalMoteur(1) <= '0';
				signalMoteur(2) <= VecteurMli(8); --moteur doit
				signalMoteur(3) <= '0';
			end if;
		elsif Cpt >= 14000 and Cpt < 21000 then  --26 000   et 32 000
			signalMoteur(0) <= '0';
			signalMoteur(1) <= VecteurMli(10);
			signalMoteur(2) <= '0';
			signalMoteur(3) <= VecteurMli(11);
		else --acquitement
			Cpt <= 0;
			CycleEvitement <= '0';
		end if;
	else
		Cpt <= 0;
	end if;
end if;
end process;
end Behavioral;

