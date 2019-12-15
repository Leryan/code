----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:53:26 02/04/2011 
-- Design Name: 
-- Module Name:    mli - Behavioral 
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

entity mli is
    Port (H100KHz : in STD_LOGIC;
          OutMLI : out  STD_LOGIC_VECTOR (0 to 100));
end mli;

architecture Behavioral of mli is
signal count: integer range 0 to 101;
begin

process (H100KHz) begin
    if H100KHz'event and H100KHz = '1' then
        count <= count + 1;
        if count = 100 then
            OutMLI <= "01111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
            count <= 0;
        elsif count > 0 and count < 100 then
            OutMLI(count) <= '0';
        end if;
    end if;
end process;

end Behavioral;
