--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity memInstru is
    Port ( addr     : in STD_LOGIC_VECTOR (3 downto 0);
           CLK      : in STD_LOGIC;
           Output   : out STD_LOGIC_VECTOR (31 downto 0));
end memInstru;

architecture Behavioral of memInstru is
    type reg_array is array (255 downto 0) of STD_LOGIC_VECTOR(31 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- Initialisé à 0
    --signal registers : reg_array := (x"12345678", others => (others => '0'));
    

begin
    --registers(1)(31 downto 24) <= x"01";    -- ADD Met dans la memoire 01, en hexa le valeur 01
    --registers(1)(23 downto 15) <= x"01";    -- Reg 01
    --registers(1)(14 downto 7) <= x"02";     -- Reg 02
    --registers(1)(7 downto 0) <= x"03";      -- Reg 03
    -- R1 = R2 + R3 (ADD)
    
    process
    begin
    wait until rising_edge(CLK);
        Output <= registers(to_integer(unsigned(addr))); 
    end process;

end Behavioral;
