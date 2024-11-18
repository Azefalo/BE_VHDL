--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity LC_OP_RE is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           W : out STD_LOGIC);
end LC_OP_RE;

architecture Behavioral of LC_OP_RE is

-- W spécifie si une écriture doit être
-- réalisée. Cette entrée est active à 1, pour une écriture

begin
    process (OP)
        begin
        
        if OP = x"08" then
            W <= '1';           -- W = 1: Sauvegarde (ecriture)
        else
            W <= '0';           -- W = 0: Copie, Affectation, Chargement (lecture)
        end if;
    end process;
    
end Behavioral;
