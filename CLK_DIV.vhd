----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Clock Divder
-- Module Name: CLK_DIV - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity CLK_DIV is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is

-- Clock Parameters    
constant clk_limit : std_logic_vector(27 downto 0) := X"000F424";
signal clk_ctr : std_logic_vector(27 downto 0);
signal temp_clk : std_logic;

begin
    -- Clock Divider Process
    process (Clk_in)
    begin
        if Clk_in = '1' and Clk_in'Event then
              if clk_ctr = clk_limit then                
                   temp_clk <= not temp_clk;     -- Switched state when desired clock cycle time is reach
                 clk_ctr <= X"0000000";          -- Resets counter       
              else                                            
                   clk_ctr <= clk_ctr + X"0000001";    -- Adds 1 to counter
              end if;
            end if;
    end process;

Clk_out <= temp_clk;    -- Assign temp clock signal to Clk_out at end of process

end Behavioral;
