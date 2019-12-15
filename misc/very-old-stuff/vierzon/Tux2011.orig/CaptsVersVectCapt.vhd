----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:59 02/23/2011 
-- Design Name: 
-- Module Name:    CaptsVersVectCapt - Behavioral 
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

entity CaptsVersVectCapt is
    Port ( VectCapt : out  STD_LOGIC_VECTOR (7 downto 0);
           Capt0 : in  STD_LOGIC;
           Capt1 : in  STD_LOGIC;
           Capt2 : in  STD_LOGIC;
			  Capt3 : in  STD_LOGIC;
			  Capt4 : in  STD_LOGIC;
			  Capt5 : in  STD_LOGIC;
			  Capt6 : in  STD_LOGIC;
           Capt7 : in  STD_LOGIC);
end CaptsVersVectCapt;

architecture Behavioral of CaptsVersVectCapt is

begin
	VectCapt(0) <= Capt0;
	VectCapt(1) <= Capt1;
	VectCapt(2) <= Capt2;
	VectCapt(3) <= Capt3;
	VectCapt(4) <= Capt4;
	VectCapt(5) <= Capt5;
	VectCapt(6) <= Capt6;
	VectCapt(7) <= Capt7;
end Behavioral;

