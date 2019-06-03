----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Debouncer
-- Module Name: Debouncer - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Debouncer is
    Port ( BTNC : in STD_LOGIC;
           CLK : in STD_LOGIC;
           reset : in STD_LOGIC;
           ButOut : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

signal Q1, Q2, Q3 : std_logic;   -- Register signals

begin
    -- Register implementation for debouncing
    process(CLK)
    begin 
        -- Update registers on clock rising edge
        if (CLK'event and CLK = '1') then
            if (reset = '1') then
                Q1 <= '0';
                Q2 <= '0';
                Q3 <= '0';
            else
                Q1 <= BTNC;
                Q2 <= Q1;
                Q3 <= Q2;
            end if;
        end if;
    end process;

    ButOut <= Q1 and Q2 and (not Q3);

end Behavioral;
