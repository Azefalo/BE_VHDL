--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistreBank is
    Port (
        CLK    : in  STD_LOGIC;             -- Horloge
        RST    : in  STD_LOGIC;             -- Reset actif à 0
        W      : in  STD_LOGIC;             -- Signal d'écriture actif à 1
        ADDR_W : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse d'écriture (4 bits)
        DATA   : in  STD_LOGIC_VECTOR(7 downto 0); -- Données d'entrée (8 bits)
        ADDR_A : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse de lecture A (4 bits)
        ADDR_B : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse de lecture B (4 bits)
        QA     : out STD_LOGIC_VECTOR(7 downto 0); -- Données de sortie A (8 bits)
        QB     : out STD_LOGIC_VECTOR(7 downto 0)  -- Données de sortie B (8 bits)
    );
end RegistreBank;

architecture Behavioral of RegistreBank is
    type reg_array is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- Initialisé à 0

begin
    process
    begin
        wait until rising_edge(CLK);
        if RST = '0' then
           registers <= (others => (others => '0')); -- Reset à 0x00 pour tous les registres
        elsif W = '1' then
            registers(to_integer(unsigned(ADDR_W))) <= DATA; -- Écriture des données
        end if;
    end process;

    -- Lecture simultanée
    QA <= DATA when (ADDR_A = ADDR_W and W = '1') else
        registers(to_integer(unsigned(ADDR_A))); 
    QB <= DATA when (ADDR_B = ADDR_W and W = '1') else
        registers(to_integer(unsigned(ADDR_B)));



end Behavioral;
