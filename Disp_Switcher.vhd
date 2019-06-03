----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Display Switcher
-- Module Name: Disp_Switcher - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Disp_Switcher is
    Port ( hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 : in STD_LOGIC_VECTOR (0 to 6);
           disp : in STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (7 downto 0);
           seg_A : out STD_LOGIC;
           seg_B : out STD_LOGIC;
           seg_C : out STD_LOGIC;
           seg_D : out STD_LOGIC;
           seg_E : out STD_LOGIC;
           seg_F : out STD_LOGIC;
           seg_G : out STD_LOGIC);
end Disp_Switcher;

architecture Behavioral of Disp_Switcher is

signal chosen_hex : STD_LOGIC_VECTOR (0 to 6);   -- Signal for possible hex values

begin
    -- Hex display value selection process
    process (disp)
    begin
        case disp is
            when "00000001" => chosen_hex <= hex0;
            when "00000010" => chosen_hex <= hex1;
            when "00000100" => chosen_hex <= hex2;
            when "00001000" => chosen_hex <= hex3;
            when "00010000" => chosen_hex <= hex4;
            when "00100000" => chosen_hex <= hex5;
            when "01000000" => chosen_hex <= hex6;
            when "10000000" => chosen_hex <= hex7;
            when others => chosen_hex <= "1111111";
        end case;
        
        anode <= not disp;
        seg_A <= chosen_hex(0);
        seg_B <= chosen_hex(1); 
        seg_C <= chosen_hex(2);
        seg_D <= chosen_hex(3);
        seg_E <= chosen_hex(4);
        seg_F <= chosen_hex(5);
        seg_G <= chosen_hex(6);
    end process;

end Behavioral;
