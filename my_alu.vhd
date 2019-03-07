----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 01:39:52 PM
-- Design Name: 
-- Module Name: my_alu - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Opcode : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (3 downto 0));
end my_alu;

architecture Behavioral of my_alu is
    type operation is (add, sub, inc, dec, sub_from_zero, greater_than,
                       shift_left_logical, shift_right_logical, shift_right_arithmetic,
                       invert, and_func, or_func, xor_func, xnor_func, nand_func, nor_func);
    
    signal current_operation : operation;
begin

    -- assign state
    with Opcode select
        current_operation <= add when "0000",
                             sub when "0001",
                             inc when "0010",
                             dec when "0011",
                             sub_from_zero when "0100",
                             greater_than when "0101",
                             shift_left_logical when "0110",
                             shift_right_logical when "0111",
                             shift_right_arithmetic when "1000",
                             invert when "1001",
                             and_func when "1010",
                             or_func when "1011",
                             xor_func when "1100",
                             xnor_func when "1101",
                             nand_func when "1110",
                             nor_func when "1111",
                             add when others;
                             
    alu_process : process(A, B, Opcode)
        variable right_shifted : std_logic_vector(3 downto 0);
    begin
        case current_operation is
            when add =>
                result <= std_logic_vector(unsigned(A) + unsigned(B));
            when sub =>
                result <= std_logic_vector(unsigned(A) - unsigned(B));
            when inc =>
                result <= std_logic_vector(unsigned(A) + 1);
            when dec =>
                result <= std_logic_vector(unsigned(A) - 1);
            when sub_from_zero =>
                result <= std_logic_vector(0 - unsigned(A));
            when greater_than =>
                if(A > B) then
                    result <= "0001";
                else
                    result <= (others => '0');
                end if;
            when shift_left_logical =>
                result <= std_logic_vector(unsigned(A) sll 1);
            when shift_right_logical =>
                result <= std_logic_vector(unsigned(A) srl 1);
            when shift_right_arithmetic =>
                right_shifted := std_logic_vector(unsigned(A) srl 1);
                result <= A(3) & right_shifted(2 downto 0);
            when invert =>
                result <= not A;
            when and_func =>
                result <= A and B;
            when or_func =>
                result <= A or B;
            when xor_func =>
                result <= A xor B;
            when xnor_func =>
                result <= A xnor B;
            when nand_func =>
                result <= A nand B;
            when nor_func =>
                result <= A nor B;
        end case;
    end process;

end Behavioral;
