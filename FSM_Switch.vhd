----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.05.2019 16:21:04
-- Design Name: 
-- Module Name: FSM_Switch - Behavioral
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

entity FSM_Switch is
    Port ( currentState : inout integer range 0 to 3;
           BTNC : in STD_LOGIC;
           reset, EnableA, EnableB, EnableOP, EnableX : out STD_LOGIC);
end FSM_Switch;

architecture Behavioral of FSM_Switch is

begin
    process (BTNC)
begin
    if BTNC'Event and BTNC='1' then
        reset <= '0';
        EnableB <= '0';
        EnableX <= '0';
        EnableOP <= '0';
        EnableA <= '0';
        if currentState = 3 then
            currentState <= 0;
        else
            currentState <= currentState + 1;
        end if;
    end if;
end process;

end Behavioral;
