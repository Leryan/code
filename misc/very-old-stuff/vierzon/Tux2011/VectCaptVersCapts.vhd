----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:27:57 02/23/2011 
-- Design Name: 
-- Module Name:    VectCaptVersCapts - Behavioral 
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

entity VectCaptVersCapts is
    Port ( VectCapt : in  STD_LOGIC_VECTOR (7 downto 0);
           Capt0 : out  STD_LOGIC;
           Capt1 : out  STD_LOGIC;
           Capt2 : out  STD_LOGIC;
			  Capt3 : out  STD_LOGIC;
			  Capt4 : out  STD_LOGIC;
			  Capt5 : out  STD_LOGIC;
			  Capt6 : out  STD_LOGIC;
           Capt7 : out  STD_LOGIC);
end VectCaptVersCapts;

architecture Behavioral of VectCaptVersCapts is

begin
	Capt0 <= not VectCapt(0);
	Capt1 <= not VectCapt(1);
	Capt2 <= not VectCapt(2);
	Capt3 <= not VectCapt(3);
	Capt4 <= not VectCapt(4);
	Capt5 <= not VectCapt(5);
	Capt6 <= not VectCapt(6);
	Capt7 <= not VectCapt(7);
end Behavioral;

