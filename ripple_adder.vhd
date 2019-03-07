----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 12:49:53 PM
-- Design Name: 
-- Module Name: ripple_adder - Behavioral
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

entity ripple_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C_0 : in STD_LOGIC;
           C_4 : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0));
end ripple_adder;

architecture Behavioral of ripple_adder is
    --Declare single full adder cells
    component adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
    end component;
    
    --signals
    signal C : STD_LOGIC_VECTOR (4 downto 0);
    
begin
    --Glue logic
    C(0) <= C_0;
    C_4 <= C(4); 
    
    --Create adder cells
    Adder_0 : adder port map(A(0), B(0), C(0), S(0), C(1));
    Adder_1 : adder port map(A(1), B(1), C(1), S(1), C(2));
    Adder_2 : adder port map(A(2), B(2), C(2), S(2), C(3));
    Adder_3 : adder port map(A(3), B(3), C(3), S(3), C(4));

end Behavioral;
