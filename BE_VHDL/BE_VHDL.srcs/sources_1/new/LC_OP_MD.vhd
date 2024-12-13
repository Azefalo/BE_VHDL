--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity LC_OP_MD is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           RW : out STD_LOGIC);
end LC_OP_MD;

architecture Behavioral of LC_OP_MD is

-- Pour réaliser une lecture, RW doit être positionné à 1
-- et pour réaliser une écriture, RW doit être positionné à 0

begin
    process (OP)
        begin
        
        if OP = x"08" then
            RW <= '1';           -- RW = 1: Sauvegarde (ecriture)
        else
            RW <= '0';           -- RW = 0: Copie, Affectation, Chargement (lecture)
        end if;
    end process;

end Behavioral;
