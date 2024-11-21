--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity MUX_UAL is
    Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_UAL;

architecture Behavioral of MUX_UAL is

begin
    
    OUTPUT <=   INPUT1 when OP = "000" else
                INPUT1 when OP = "001" else
                INPUT1 when OP = "010" else
                INPUT2;
    
end Behavioral;
