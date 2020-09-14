library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexers is
    Port ( SuivitBalise : in  STD_LOGIC_VECTOR (3 downto 0);
           Cycle_Evitement : in  STD_LOGIC_VECTOR (3 downto 0);
           Debut_Fin_Course : in  STD_LOGIC_VECTOR (3 downto 0);
			  telecommander : in  STD_LOGIC_VECTOR (3 downto 0);
           Moteurs : out  STD_LOGIC_VECTOR (3 downto 0);
           Jack : in  STD_LOGIC;
           Mode_Evitement : in  STD_LOGIC;
           Fin_Course : in  STD_LOGIC;
			  fin_com : in STD_LOGIC);
end Multiplexers;

architecture Behavioral of Multiplexers is
signal telecom : std_logic := '0';
begin
process
begin
--jack enlevé
	if Jack = '1' then
		--Si événement -> abandon précommande
		if Mode_Evitement = '1' or Fin_Course = '1' or fin_com = '1' then
			telecom <= '0';
		end if;
		--Si fin course -> Debut_Fin_Course
		if Fin_Course = '1' then
			Moteurs <= Debut_Fin_Course;
		--Si PAS FC -> cas en fonctionnement
		else
			--Obstable -> Evitement
			if Mode_Evitement = '1' then
				Moteurs <= Cycle_Evitement;
			--fin telecom -> Suivre Balise
			elsif telecom = '1' then
				Moteurs <= telecommander;
			else
				Moteurs <= SuivitBalise;
			end if;
		end if;
	--Si jack -> arrêt et mode précommandé
	elsif Jack = '0' then
		telecom <= '1';
		Moteurs <= "0000";
	end if;
end process;
end Behavioral;

