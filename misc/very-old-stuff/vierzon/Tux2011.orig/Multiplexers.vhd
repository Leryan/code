----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:42:18 04/20/2011 
-- Design Name: 
-- Module Name:    Multiplexers - Behavioral 
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

entity Multiplexers is
    Port ( SuivitBalise : in  STD_LOGIC_VECTOR (3 downto 0);
           Cycle_Evitement : in  STD_LOGIC_VECTOR (3 downto 0);
           Debut_Fin_Course : in  STD_LOGIC_VECTOR (3 downto 0);
           Moteurs : out  STD_LOGIC_VECTOR (3 downto 0);
           Jack : in  STD_LOGIC;
           Mode_Evitement : in  STD_LOGIC;
           Fin_Course : in  STD_LOGIC);
end Multiplexers;

architecture Behavioral of Multiplexers is
signal telecom : std_logic := '0';

begin
process
begin
	if Jack = '1' and Mode_Evitement = '0' and Fin_Course = '0' then Moteurs <= SuivitBalise; end if;
	if Jack = '1' and Mode_Evitement = '1' and Fin_Course = '0' then Moteurs <= Cycle_Evitement; end if;
	if Jack = '0' or Fin_Course = '1' then Moteurs <= Debut_Fin_Course; end if;
end process;
end Behavioral;

