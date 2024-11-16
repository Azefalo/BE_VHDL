--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity MUX is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           INPUT1 : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT2 : in STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
    
    OUTPUT <=   INPUT1 when OP = "000" else
                INPUT2 when OP = "001";
    
end Behavioral;
