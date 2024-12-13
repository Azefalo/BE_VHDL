--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX_UAL is
    Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
end MUX_UAL;

architecture Behavioral of MUX_UAL is
begin
    process(OP, INPUT1, INPUT2)
    begin
        case OP(2 downto 0) is  -- Utiliza apenas os 3 bits menos significativos
            when "000" => OUTPUT <= INPUT1;
            when "001" => OUTPUT <= INPUT1;
            when "010" => OUTPUT <= INPUT1;
            when others => OUTPUT <= INPUT2;
        end case;
    end process;
end Behavioral;