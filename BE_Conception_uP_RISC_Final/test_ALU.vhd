--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_ALU is
end test_ALU;

architecture Behavioral of test_ALU is
        
    component ALU is
        Port(   A           : in  STD_LOGIC_VECTOR(7 downto 0);
                B           : in  STD_LOGIC_VECTOR(7 downto 0);
                Ctrl_Alu    : in  STD_LOGIC_VECTOR(2 downto 0);
                res         : out STD_LOGIC_VECTOR(7 downto 0);
                C           : out STD_LOGIC;
                O           : out STD_LOGIC;
                N           : out STD_LOGIC);
    end component;

    signal S_A          : std_logic_vector (7 downto 0);
    signal S_B          : std_logic_vector (7 downto 0);
    signal S_operation  : std_logic_vector (2 downto 0);
    
    signal S_result         : std_logic_vector (7 downto 0);
    signal S_f_carry_add    : std_logic; 
    signal S_f_overflow_mul : std_logic;
    signal S_f_negative     : std_logic;
    begin
        ALU1: ALU PORT MAP (S_A,S_B,S_operation,S_result,S_f_carry_add,S_f_overflow_mul,S_f_negative);

        
    S_A <= "00000001", "11111111" after 10 ns, "00000010" after 20 ns, "00000001" after 30 ns, "00000010" after 40 ns, "11111111" after 50 ns, "01010101" after 60 ns, "01010101" after 80 ns, "01010101" after 100 ns, "01010101" after 120 ns, "01010101" after 140 ns; 
    S_B <= "00000001", "00000001" after 10 ns, "00000001" after 20 ns, "00000010" after 30 ns, "00000010" after 40 ns, "00000010" after 50 ns, "11000011" after 60 ns, "11000011" after 80 ns, "11000011" after 100 ns, "11000011" after 120 ns, "11111111" after 140 ns;
    S_operation <= "000", "001" after 20 ns, "110" after 40 ns, "010" after 60 ns, "011" after 80 ns, "100" after 100 ns, "101" after 120 ns, "111" after 140 ns ; 

end Behavioral;