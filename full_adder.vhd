----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Full Adder
-- Module Name: full_adder - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( adderA, adderB, adderCin: in STD_LOGIC;
           adderSUM, adderCout : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

begin

-- Full adder logic
adderSUM <= (adderA XOR adderB) XOR adderCin;
adderCout <= ((adderA XOR adderB) AND adderCin) OR
             (adderA AND adderB);

end Behavioral;
