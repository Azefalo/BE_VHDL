--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL; 
use IEEE.std_logic_unsigned.ALL; 

entity memInstru is
    Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
           CLK      : in STD_LOGIC;
           Output   : out STD_LOGIC_VECTOR (31 downto 0)
    );
end memInstru;

architecture Behavioral of memInstru is
    
    type reg_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array;

begin
        
    -- Initialisation des registres
    Registers(0) <= x"00" & x"00" & x"00" & x"00";
    
    -- Instructions d'affectation
    Registers(1) <= x"06" & x"01" & x"26" & x"00"; -- AFC R1, 0x26
    Registers(2) <= x"06" & x"02" & x"45" & x"00"; -- AFC R2, 0x45
    Registers(3) <= x"06" & x"03" & x"15" & x"00"; -- AFC R3, 0x15
    
    -- Instruction de copie
    Registers(4) <= x"05" & x"04" & x"01" & x"00"; -- COP R4, R1
    Registers(5) <= x"05" & x"05" & x"02" & x"00"; -- COP R5, R2
    
    -- Instructions de sauvegarde
    Registers(6) <= x"08" & x"00" & x"02" & x"11"; -- STORE [0], R2
    Registers(7) <= x"08" & x"02" & x"02" & x"22"; -- STORE [2], R3
    Registers(8) <= x"08" & x"03" & x"03" & x"33"; -- STORE [3], R3
    
    -- Instructions de chargement
    Registers(12) <= x"07" & x"06" & x"00" & x"00"; -- LOAD R6, [0]
    Registers(13) <= x"07" & x"07" & x"00" & x"01"; -- LOAD R7, [1]
    
    -- Instructions arithmétiques
    Registers(15) <= x"01" & x"08" & x"01" & x"02"; -- ADD R8, R1, R2
    Registers(16) <= x"03" & x"09" & x"02" & x"03"; -- SUB R9, R2, R3
    Registers(17) <= x"02" & x"0A" & x"03" & x"04"; -- MUL R10, R3, R4
    
    process
    begin
        wait until rising_edge(CLK);
        Output <= registers(conv_integer(addr)); 
    end process;

end Behavioral;
