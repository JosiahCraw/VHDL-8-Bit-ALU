----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: 8 Bit ALU
-- Module Name: ALU8bit - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
-- Dependencies: ALU1bit.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.NUMERIC_STD.ALL;


entity ALU8bit is
    Port ( A, B : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (3 downto 0);
           X : out STD_LOGIC_VECTOR (7 downto 0);
           Cout, Neg : out STD_LOGIC);
end ALU8bit;

architecture Behavioral of ALU8bit is

-- ALU 1-bit Compenent Declaration
component ALU1bit is
    Port ( A, B, Cin: in STD_LOGIC;
           OP: in STD_LOGIC_VECTOR(3 downto 0);
           X, Cout: out STD_LOGIC);
end component;

-- Signal declarations for 1-bit ALU carries, subTrue, and the 8-bit result
signal cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7: STD_LOGIC;
signal subTrue : STD_LOGIC;
signal Result, Output : STD_LOGIC_VECTOR(7 downto 0);

begin
    subTrue <= '1' when OP = "0001" else '0'; -- Set carry in if doing subtraction
    
    -- 8-bit ALU implementation
    alu0: ALU1bit port map (A(0), B(0), subTrue, OP, Result(0), cout0);
    alu1: ALU1bit port map (A(1), B(1), cout0, OP, Result(1), cout1);
    alu2: ALU1bit port map (A(2), B(2), cout1, OP, Result(2), cout2);
    alu3: ALU1bit port map (A(3), B(3), cout2, OP, Result(3), cout3);
    alu4: ALU1bit port map (A(4), B(4), cout3, OP, Result(4), cout4);
    alu5: ALU1bit port map (A(5), B(5), cout4, OP, Result(5), cout5);
    alu6: ALU1bit port map (A(6), B(6), cout5, OP, Result(6), cout6);
    alu7: ALU1bit port map (A(7), B(7), cout6, OP, Result(7), cout7);
    
    Cout <= cout7 AND not subTrue;
    Neg <= subTrue and '1' when B > A else '0';
    
    Output <= Result when subTrue = '0' or B < A else (not Result) + "00000001";
    
    X <= Output;

end Behavioral;
