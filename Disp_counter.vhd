----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Display Counter
-- Module Name: Disp_Counter - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Disp_counter is
    Port ( Clk_in : in STD_LOGIC;
           Disp_out : out STD_LOGIC_VECTOR (7 downto 0));
end Disp_counter;

architecture Behavioral of Disp_counter is

signal count : integer range 1 to 8;   -- Counter signal 

begin
    -- Muxing between the 8 7-SEG displays
    process (Clk_in)
    begin
        if Clk_in'Event and Clk_in='1' then            
            if count = 8 then
                count <= 1;
            else
                count <= count + 1;
            end if;
        end if;
        
        -- Converting from integer to anode state
        case count is
            when 8 => Disp_out <= "10000000";
            when 7 => Disp_out <= "01000000";
            when 6 => Disp_out <= "00100000";
            when 5 => Disp_out <= "00010000";
            when 4 => Disp_out <= "00001000";
            when 3 => Disp_out <= "00000100";
            when 2 => Disp_out <= "00000010";
            when 1 => Disp_out <= "00000001";
            
        end case;
    end process;
        
end Behavioral;
