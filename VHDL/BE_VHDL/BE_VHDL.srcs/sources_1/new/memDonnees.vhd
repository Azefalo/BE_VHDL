--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memDonnees is
    Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
           Data     : in STD_LOGIC_VECTOR (7 downto 0);
           RW       : in STD_LOGIC;
           RST      : in STD_LOGIC;
           CLK      : in STD_LOGIC;
           Output   : out STD_LOGIC_VECTOR (7 downto 0));
end memDonnees;

architecture Behavioral of memDonnees is

    type reg_array is array (255 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 256 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- Initialisé à 0

begin
    process
    begin
        wait until rising_edge(CLK);
        if RST = '0' then
           registers <= (others => (others => '0')); -- Reset à 0x00 pour tous les registres
        elsif RW = '0' then
            registers(to_integer(unsigned(addr))) <= Data; -- Écriture des données
        elsif RW = '1' then
            Output <= registers(to_integer(unsigned(addr)));   
        end if;
    end process;

end Behavioral;
