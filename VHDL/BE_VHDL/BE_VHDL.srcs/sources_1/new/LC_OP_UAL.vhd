--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity LC_OP_UAL is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : out STD_LOGIC_VECTOR (2 downto 0));
end LC_OP_UAL;

architecture Behavioral of LC_OP_UAL is
-- Le signal Ctrl_Alu informera
-- sur l'opération à réaliser : Addition, Soustraction,
-- Multiplication ou opérations logiques (AND, OR, XOR, NOT).


begin
    process (OP)
        begin
        Ctrl_Alu <= OP(2 downto 0);
    end process;
    
end Behavioral;
