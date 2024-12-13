--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX_MD1 is
    Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_MD1;

architecture Behavioral of MUX_MD1 is
begin
    process(OP, INPUT1, INPUT2)
    begin
        case OP is
            when x"07" => OUTPUT <= INPUT1;
            when x"08" => OUTPUT <= INPUT2;
            when others => OUTPUT <= x"00"; -- Valor padrão
        end case;
    end process;
end Behavioral;