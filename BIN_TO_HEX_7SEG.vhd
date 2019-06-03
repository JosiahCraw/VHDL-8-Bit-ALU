----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Binary to Hex converter
-- Module Name: BIN_TO_HEX - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BIN_TO_HEX is
    Port ( BIN : in STD_LOGIC_VECTOR(3 downto 0); -- 4 bit binary number
           HEX : out STD_LOGIC_VECTOR(6 downto 0)); -- Bit pattern for 7 seg hex output
end BIN_TO_HEX;

architecture Behavioral of BIN_TO_HEX is


begin
    -- Convert Binary number to Bit pattern for 7 seg hex output
    process(BIN)
    
    begin
        case BIN is             -- abcdefg
            when "0000" => HEX <= "0000001";
            when "0001" => HEX <= "1001111";
            when "0010" => HEX <= "0010010";
            when "0011" => HEX <= "0000110";
            when "0100" => HEX <= "1001100";
            when "0101" => HEX <= "0100100";
            when "0110" => HEX <= "0100000";
            when "0111" => HEX <= "0001111";
            when "1000" => HEX <= "0000000";
            when "1001" => HEX <= "0000100";
            when "1010" => HEX <= "0001000";
            when "1011" => HEX <= "1100000";
            when "1100" => HEX <= "0110001";
            when "1101" => HEX <= "1000010";
            when "1110" => HEX <= "0110000";
            when "1111" => HEX <= "0111000";
            when others => HEX <= "1111111";
        end case;
        
    end process;
    
end Behavioral;
