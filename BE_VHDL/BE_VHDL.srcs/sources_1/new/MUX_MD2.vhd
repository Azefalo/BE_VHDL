--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity MUX_MD2 is
    Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_MD2;

architecture Behavioral of MUX_MD2 is

begin
    
    OUTPUT <=   INPUT1 when OP = x"07" else
                INPUT2;
    
end Behavioral;
