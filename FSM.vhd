----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2019 16:21:04
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    Port ( state : in integer range 0 to 3;
           currentState : out STD_LOGIC_VECTOR (3 downto 0);
           hex7 : out STD_LOGIC_VECTOR (6 downto 0);
           hex6 : out STD_LOGIC_VECTOR (6 downto 0);
           hex2 : out STD_LOGIC_VECTOR (6 downto 0);
           hex3 : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           main_out : in STD_LOGIC_VECTOR (7 downto 0);
           EnableA : out STD_LOGIC;
           Neg : in STD_LOGIC;
           Cout : in STD_LOGIC;
           EnableB : out STD_LOGIC;
           EnableOP : out STD_LOGIC;
           EnableX : out STD_LOGIC;
           hex_to_disp : out STD_LOGIC_VECTOR (7 downto 0);
           reset : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

begin
-- FSM state swicther
   process (state) --Should this be clk
        begin
        case state is
                when 0 =>
                    reset <= '0';
                    currentState <= "0001";
                    hex7 <= "0001000"; -- A
                    hex6 <= "1111111"; -- Empty
                    EnableA <= '1';
                    hex3 <= "1111111";
                    hex2 <= "0000001";
                    hex_to_disp <= "00000000"; -- Clear Display
                when 1 =>
                    reset <= '0';
                    currentState <= "0010";
                    hex7 <= "1100000"; -- B
                    hex6 <= "1111111"; -- Empty
                    EnableB <= '1';
                    hex3 <= "1111111";
                    hex2 <= "0000001";
                    hex_to_disp <= "00000000"; -- Clear Display
                when 2 =>
                    reset <= '0';
                    currentState <= "0100";
                    hex7 <= "0000001"; -- O
                    hex6 <= "0011000"; -- P
                    EnableOP <= '1';
                    hex3 <= "1111111";
                    hex2 <= "0000001";
                    hex_to_disp <= "00000000"; -- Clear Display
                when 3 =>
                    reset <= '0';
                    hex7 <= "1111111"; -- Empty
                    hex6 <= "1111111"; -- Empty
                    currentState <= "1000";
                    EnableX <= '1';
                    LED(7 downto 0) <= main_out;
                    hex_to_disp <= main_out;
                    LED(8) <= Cout;
                    if Cout = '1' then
                        hex2 <= "1001111"; -- 1
                    else
                        hex2 <= "0000001"; -- 0
                    end if;
                    LED(9) <= Neg;
                    if Neg = '1' then
                        hex3 <= "1111110"; -- '-'
                    else
                        hex3 <= "1111111"; -- Empty
                    end if;
            end case;    
    end process;

end Behavioral;
