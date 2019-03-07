----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 02:19:07 PM
-- Design Name: 
-- Module Name: alu_tester - Behavioral
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

entity alu_tester is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           btn, sw : in STD_LOGIC_VECTOR (3 downto 0));
end alu_tester;

architecture Behavioral of alu_tester is
    --Declare components
    component debounce is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           dbnce : out STD_LOGIC);
    end component;
    
    component my_alu is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    --Signals
    
    --Registers to store input values
    signal btn_in, A_input, B_input, Opcode_input, ALU_Result, ALU_temp_ans : std_logic_vector (3 downto 0)
           := (others => '0');
begin

    --Instantiate components
    db0 : debounce port map(btn(0), clk, btn_in(0));
    db1 : debounce port map(btn(1), clk, btn_in(1));
    db2 : debounce port map(btn(2), clk, btn_in(2));
    db3 : debounce port map(btn(3), clk, btn_in(3));
    alu : my_alu port map(A_input, B_input, Opcode_input, ALU_temp_ans);
    
    --Glue logic
    led <= ALU_result;
    
    --process to load in user input
    main : process(clk)
    begin
        if(rising_edge(clk)) then
            
            --Get B
            if(btn_in(0) = '1') then
                B_input <= sw; 
            end if;
             
            --Get A
            if(btn_in(1) = '1') then
                A_input <= sw; 
            end if;
             
            --Get Opcode
            if(btn_in(2) = '1') then
                Opcode_input <= sw; 
            end if;
            
            --Clear
            if(btn_in(3) = '1') then
                Opcode_input <= (others => '0'); 
                A_input <= (others => '0');
                B_input <= (others => '0');
            end if;
            
            --Load output
            ALU_result <= ALU_temp_ans;
        end if;
    end process;

end Behavioral;
