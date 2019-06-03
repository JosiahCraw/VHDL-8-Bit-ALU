----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019 13:08:25
-- Design Name: 1 Bit ALU
-- Module Name: ALU1bit - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
-- Dependencies: full_adder.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity ALU1bit is
    Port ( A, B, Cin: in STD_LOGIC;
           OP: in STD_LOGIC_VECTOR(3 downto 0);
           X, Cout: out STD_LOGIC);
end ALU1bit;

architecture Behavioral of ALU1bit is

-- Full Adder Component Definition
component full_adder is
    Port (adderA, adderB, adderCin: in STD_LOGIC;
          adderSUM, adderCout: out STD_LOGIC);
end component;

signal mux1, sum: STD_LOGIC;

begin

    g0: full_adder 
    port map (
            adderA => A, adderB => mux1, adderCin => Cin, 
            adderSUM => sum, adderCout => Cout
    );
    
    -- Implement OP code selection
    mux1 <= not B when OP ="0001" else B;
    
    process (A, B, OP, sum)
    begin    
        case OP is
            when "0010" => X <= A AND B;
            when "0011" => X <= A OR B;
            when others => X <= sum;
        end case;
    end process;

end Behavioral;
