----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:57 05/13/2011 
-- Design Name: 
-- Module Name:    Microcontroleur - Behavioral 
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

entity Microcontroleur is
    Port ( VecteurMli : in  STD_LOGIC_VECTOR (15 downto 0);
           signalMoteur : out  STD_LOGIC_VECTOR (3 downto 0));
end Microcontroleur;

architecture Behavioral of Microcontroleur is

begin
	signalMoteur(0) <= '0';
	signalMoteur(1) <= VecteurMli(5);
	signalMoteur(2) <= '0';
	signalMoteur(3) <= VecteurMli(5);
end Behavioral;

