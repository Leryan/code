----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:43:18 02/23/2011 
-- Design Name: 
-- Module Name:    Clk28MHzTo100MHz - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clk28MHzTo100KHz is
    Port (Clk28MHz : in  STD_LOGIC;
             Clk100KHz : inout  STD_LOGIC);
end Clk28MHzTo100KHz;

architecture Behavioral of Clk28MHzTo100KHz is
signal Cpt : integer range 0 to 280 := 0;
begin

process(Clk28MHz) begin
	if Clk28MHz'event and Clk28MHz = '1' then
		Cpt <= Cpt + 1;
		if Cpt = 140 then
			Clk100KHz <= not(Clk100KHz);
			Cpt <= 0;
		end if;
	end if;
end process;

end Behavioral;

