			----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:25:21 05/20/2011 
-- Design Name: 
-- Module Name:    telecommander - Behavioral 
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

entity telecommander is
    Port ( VecteurMli : in  STD_LOGIC_VECTOR (15 downto 0);
	        Clk10KHz : in  STD_LOGIC;
			  Jack : in  STD_LOGIC;
           signalMoteur : out  STD_LOGIC_VECTOR (3 downto 0);
			  fin_com : out STD_LOGIC);
end telecommander;

architecture Behavioral of telecommander is
signal CptTourneGauche : integer range 0 to 32000;
signal CptTourneDroite : integer range 0 to 32000;
signal tourneGauche : std_logic;
signal tourneDroite : std_logic;
signal Step1 : integer range 0 to 130000;
signal CptStep1 : integer range 0 to 130000;
signal Step2 : integer range 0 to 130000;
signal CptStep2 : integer range 0 to 130000;
signal Step3 : integer range 0 to 130000;
signal CptStep3 : integer range 0 to 130000;
signal Step4 : integer range 0 to 130000;
signal CptStep4 : integer range 0 to 130000;
signal Step5 : integer range 0 to 130000;
signal CptStep5 : integer range 0 to 130000;
signal Step6 : integer range 0 to 130000;
signal CptStep6 : integer range 0 to 130000;
signal DureeRotation : integer range 0 to 16000;

begin
--		remplir les durees de chaque etape (step) : exemple Step1 <= 50000 pour 5s ( 1s = 10 000)
-- 				Chaque etape mise a 0 ne sera pas pris en compte, 6 etape au maximum 
-- 							Apres l'etapt 6, le robot ira toujours tout droit
-- 					  		!!   DUREE MAXIMUM ENTRE 2 ETAPE 13 SECONDES   !!
		Step1 <= 20000;
		Step2 <= 8000;
		Step3 <= 0;
		Step4 <= 0;
		Step5 <= 0;
		Step6 <= 0;
		
--		remplir la durees de rotation pour effectuer un angle de 90°
		DureeRotation <= 6000;
		
process(Clk10KHz)
begin
if Clk10KHz'event and Clk10KHz = '1' then		
	if Jack = '0' then
		CptStep1 <= 0; CptStep2 <= 0; CptStep3 <= 0; 
		CptStep4 <= 0; CptStep5 <= 0; CptStep6 <= 0;
		fin_com <= '0';
		tourneDroite <= '0'; tourneGauche <= '0';
	else	
-- 	Step 1 : decommenter la ligne qui nous interesse	
		if ((Cptstep1 = step1) and (step1 > 0)) then
			tourneDroite <= '1';
			----tourneGauche <= '1';
		elsif ((Cptstep2 = step2) and (step2 > 0)) then
			--tourneDroite <= '1';
			tourneGauche <= '1';
		elsif ((Cptstep3 = step3) and (step3 > 0)) then
			--tourneDroite <= '1';
			--tourneGauche <= '1';
		elsif ((Cptstep4 = step4) and (step4 > 0)) then
			--tourneDroite <= '1';
			--tourneGauche <= '1';
		elsif ((Cptstep5 = step5) and (step5 > 0)) then
			--tourneDroite <= '1';
			--tourneGauche <= '1';
		elsif ((Cptstep6 = step6) and (step6 > 0)) then
			--tourneDroite <= '1';
			--tourneGauche <= '1';
		end if;
		
		if TourneDroite = '0' and TourneGauche = '0' then
			if CptStep1 <= step1 then CptStep1 <= CptStep1 + 1;
			elsif Cptstep2 <= step2 then CptStep2 <= CptStep2 + 1;
			elsif Cptstep3 <= step3 then CptStep3 <= CptStep3 + 1;
			elsif Cptstep4 <= step4 then CptStep4 <= CptStep4 + 1;
			elsif Cptstep5 <= step5 then CptStep5 <= CptStep5 + 1;
			elsif Cptstep6 <= step6 then CptStep6 <= CptStep6 + 1;
			else
				fin_com <= '1';
			end if;
		end if;

		if ((tourneDroite = '1') and (CptTourneDroite < DureeRotation)) then
			CptTourneDroite <= CptTourneDroite + 1;
			signalMoteur(0) <= '0';
			signalMoteur(1) <= '0';
			signalMoteur(2) <= '0';
			signalMoteur(3) <= VecteurMli(5);
		elsif ((tourneGauche = '1') and (CptTourneGauche < DureeRotation)) then
			CptTourneGauche <= CptTourneGauche + 1;
			signalMoteur(0) <= '0';
			signalMoteur(1) <= VecteurMli(5);
			signalMoteur(2) <= '0';
			signalMoteur(3) <= '0';
		else --aller tout droit
			if CptTourneDroite >= DureeRotation or CptTourneGauche >= DureeRotation then
				CptTourneDroite <= 0; CptTourneGauche <= 0;
				tourneDroite <= '0'; tourneGauche <= '0';
			end if;
			signalMoteur(0) <= '0';
			signalMoteur(1) <= VecteurMli(10);
			signalMoteur(2) <= '0';
			signalMoteur(3) <= VecteurMli(11);
		end if;
	end if;
end if;
end process;
end Behavioral;

