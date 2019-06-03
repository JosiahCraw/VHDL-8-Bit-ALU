----------------------------------------------------------------------------------
-- Authors: J. Craw, D. Davis, T. de Ridder
-- 
-- Create Date: 13.03.2019
-- Design Name: Main Project File
-- Module Name: ALU_FSM_Regs - Behavioral
-- Project Name: ALU Project
-- Target Devices: Artix-7
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_FSM_Regs is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           BTNC : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (15 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end ALU_FSM_Regs;

architecture Behavioral of ALU_FSM_Regs is

-- 8-bit ALU Component Declaration
component ALU8bit is
    Port ( A, B : in STD_LOGIC_VECTOR (7 downto 0);
           OP : in STD_LOGIC_VECTOR (3 downto 0);
           X : out STD_LOGIC_VECTOR (7 downto 0);
           Cout, Neg : out STD_LOGIC);
end component;

-- Clock Divider Component Declaration
component CLK_DIV is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

-- Display Counter Component Declaration
component Disp_counter is
    Port ( Clk_in : in STD_LOGIC;
           Disp_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Display Switcher Component Declaration
component Disp_Switcher is
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
end component;

-- Binaryb to Hexidecimal Component Declaration
component BIN_TO_HEX is
    Port ( BIN : in STD_LOGIC_VECTOR(3 downto 0);--BIN : in STD_LOGIC_VECTOR(3 downto 0); -- 4 bit binary number
           HEX : out STD_LOGIC_VECTOR(6 downto 0)); -- Bit pattern for 7 seg hex output
end component;

-- Debouncer Component Declaration
component Debouncer is
    Port ( BTNC : in STD_LOGIC;
           CLK : in STD_LOGIC;
           reset : in STD_LOGIC;
           ButOut : out STD_LOGIC);
end component;

-- 8-bit Register Component Declaration
component Register_8bit is
    Port ( Data : in STD_LOGIC_VECTOR (7 downto 0);
           RESET, Enable, Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (7 downto 0) );
end component;

component FSM is
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
end component;

-- 4-bit Register Component Declaration
component Register_4bit is
    Port ( Data : in STD_LOGIC_VECTOR (3 downto 0);
           RESET, Enable, Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (3 downto 0) );
end component;

component FSM_Switch is
    Port ( currentState : inout integer range 0 to 3;
           BTNC : in STD_LOGIC;
           reset, EnableA, EnableB, EnableOP, EnableX : out STD_LOGIC);
end component;

signal main_clk : STD_LOGIC;

--Display Signals
signal disp_clk : STD_LOGIC; --Clock at 200Hz for 7 seg diplays
signal disp_selection : STD_LOGIC_VECTOR (7 downto 0); --One hot vector indicating which 7 seg is lit 
signal hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 : STD_LOGIC_VECTOR (0 to 6):= "1111111"; --Vector with each value repersenting a segment of the display
signal hex_to_disp : STD_LOGIC_VECTOR (7 downto 0); --Vector representing the value X in binary 

--Main singal IN/OUT bus
signal main_bus : STD_LOGIC_VECTOR(7 downto 0);

--ALU Signals
signal Ain, Bin, Xout, main_out : STD_LOGIC_VECTOR(7 downto 0);
signal OPCode : STD_LOGIC_VECTOR(3 downto 0);
signal Cout, Neg : STD_LOGIC;

--State machine values
signal stateLED : STD_LOGIC_VECTOR(3 downto 0);
signal currentState : integer range 0 to 3;


signal ButOut, Count : STD_LOGIC;

--Register Values
signal reset, ResetA, ResetB, ResetX, ResetOP : STD_LOGIC := '0';
signal EnableA, EnableB, EnableX, EnableOP : STD_LOGIC := '0';

begin
    --Define Clock
    main_clk <= CLK100MHZ;


    --ALU
    alu0: ALU8bit port map (Ain, Bin, OPCode,
         Xout, Cout, Neg);
         
    --Main clock divider
    Clk_div0: CLK_DIV port map (main_clk, disp_clk);
    
    --BTNC debouncer
    debouncer0: Debouncer port map (BTNC, disp_clk, reset, ButOut);
    
    --Counter To set active display
    disp_counter0: Disp_counter port map (disp_clk, disp_selection);
    
    --Switcher to put data to active display
    disp_switcher0: Disp_Switcher port map (hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7,
        disp_selection, AN, CA, CB, CC, CD, CE, CF, CG);
    
    --Binary to hex converters
    bin_to_hex0: BIN_TO_HEX port map (hex_to_disp(3 downto 0), hex0); --Screen 1
    bin_to_hex1: BIN_TO_HEX port map (hex_to_disp(7 downto 4), hex1); --Screen 2
    
    --Registers
    rA: Register_8bit port map (main_bus, ResetA, EnableA, main_clk, Ain);
    rB: Register_8bit port map (main_bus, ResetB, EnableB, main_clk, Bin);
    rX: Register_8bit port map (Xout, ResetX, EnableX, main_clk, main_out);
    
    rOP: Register_4bit port map (main_bus(3 downto 0), ResetOP, EnableOP, main_clk, OPCode);
    
    fsmach: FSM port map (currentState, stateLED, hex7, hex6, hex2, hex3, LED, main_out, EnableA, Neg, Cout, EnableB, EnableOP, EnableX, hex_to_disp, reset);
       
    fsmswitch: FSM_Switch port map (currentState, ButOut, reset, EnableA, EnableB, EnableOP, EnableX);
   
    
    main_bus <= SW(7 downto 0);
    LED(15 downto 12) <= stateLED;
    
end Behavioral;
