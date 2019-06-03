----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: 8-bit Register
-- Module Name: Register_8bit - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_8bit is
    Port ( Data : in STD_LOGIC_VECTOR (7 downto 0);
           RESET, Enable, Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (7 downto 0) );
end Register_8bit;

architecture Behavioral of Register_8bit is

signal Storage : STD_LOGIC_VECTOR (7 downto 0);   -- Register value storage

begin
    -- 8-bit register implementation
    process(Clk)
    begin
        if Enable='1' then
            Storage <= Data;                -- Input value stored
        end if;
        if RESET'event and RESET='1' then
            Storage <= "00000000";          -- Clearing of stored value
        end if;
    end process;
    
    DataOut <= Storage;
end Behavioral;
