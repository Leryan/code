----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:53:13 03/31/2011 
-- Design Name: 
-- Module Name:    ecart_tsop - Behavioral 
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

entity ecart_tsop is
    Port (tsop : in  STD_LOGIC_VECTOR (0 to 7);
          MLI  : in STD_LOGIC_VECTOR (0 to 100);
          ecart : out STD_LOGIC_VECTOR (0 to 4);
          GpDpGmDm : out STD_LOGIC_VECTOR (0 to 3)); -- 0: Gauche Plus; 1: Droite Plus; 2: Gauche Moins; 3: Droite Moins
end ecart_tsop;

architecture Behavioral of ecart_tsop is
begin
    process(tsop) begin
        if tsop(0 to 4) = '1' then
        end if;
    end process;
end Behavioral;

