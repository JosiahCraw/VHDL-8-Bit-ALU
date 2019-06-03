----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: 4-bit Register
-- Module Name: Register_4bit - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_4bit is
    Port ( Data : in STD_LOGIC_VECTOR (3 downto 0);
           RESET, Enable, Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (3 downto 0) );
end Register_4bit;

architecture Behavioral of Register_4bit is

signal Storage : STD_LOGIC_VECTOR (3 downto 0);  -- Register value storage

begin
    -- 4-bit register implementation
    process (Clk)
    begin
        if Enable='1' then
            Storage <= Data;                -- Input value storage
        end if;
        if RESET'event and RESET='1' then
            Storage <= "0000";              -- Reset of register value
        end if;
    end process;
    
    DataOut <= Storage;

end Behavioral;
