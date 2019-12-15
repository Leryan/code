--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:56:49 04/14/2011
-- Design Name:   
-- Module Name:   F:/Projet/ProjetRobo/essayJack.vhd
-- Project Name:  ProjetRobo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Debut_Fin_Course
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY essayJack IS
END essayJack;
 
ARCHITECTURE behavior OF essayJack IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debut_Fin_Course
    PORT(
         Jack : IN  std_logic;
         LEDrouge : OUT  std_logic;
         LEDverte : OUT  std_logic;
         FinCourse : IN  std_logic;
         Clk10Hz : IN  std_logic;
         SignalMoteurEntree : IN  std_logic_vector(3 downto 0);
         SignalMoteurSortie : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Jack : std_logic := '0';
   signal FinCourse : std_logic := '0';
   signal Clk10Hz : std_logic := '0';
   signal SignalMoteurEntree : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal LEDrouge : std_logic;
   signal LEDverte : std_logic;
   signal SignalMoteurSortie : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clk10Hz_period : time := 100 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Debut_Fin_Course PORT MAP (
          Jack => Jack,
          LEDrouge => LEDrouge,
          LEDverte => LEDverte,
          FinCourse => FinCourse,
          Clk10Hz => Clk10Hz,
          SignalMoteurEntree => SignalMoteurEntree,
          SignalMoteurSortie => SignalMoteurSortie
        );

   -- Clock process definitions
   Clk10Hz_process :process
   begin
		Clk10Hz <= '0';
		wait for Clk10Hz_period/2;
		Clk10Hz <= '1';
		wait for Clk10Hz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ms;	

      wait for Clk10Hz_period*100;

      -- insert stimulus here
		SignalMoteurEntree <= "0101";
		Jack <= '1';
		wait for 100 ms;
		Jack <= '0';
      wait;
   end process;

END;
