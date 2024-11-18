--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BancMemoire is
    Port (
        ADDR        : in  STD_LOGIC_VECTOR(7 downto 0); -- Adresse de lecture A (4 bits)
        DATA        : in  STD_LOGIC_VECTOR(7 downto 0); -- Adresse d'écriture (4 bits)
        RW          : in  STD_LOGIC;             -- Signal d'écriture actif à 1
        RST         : in  STD_LOGIC;             -- Reset actif à 0
        CLK         : in  STD_LOGIC;             -- Horloge
        OUTPUT_data : out STD_LOGIC_VECTOR(7 downto 0); -- Données de sortie A (8 bits)
        OUTPUT_inst : out STD_LOGIC_VECTOR(31 downto 0) -- Données de sortie A (32 bits)
    );
end entity;

architecture Behavioral1 of BancMemoire is
    type reg_array is array (255 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- Initialisé à 0
    
component MemoireDonnes is
    Port (
        ADDR1        : in  STD_LOGIC_VECTOR(7 downto 0); -- Adresse de lecture A (4 bits)
        DATA        : in  STD_LOGIC_VECTOR(7 downto 0); -- Adresse d'écriture (4 bits)
        RW          : in  STD_LOGIC;             -- Signal d'écriture actif à 1
        RST         : in  STD_LOGIC;             -- Reset actif à 0
        CLK         : in  STD_LOGIC;             -- Horloge
        OUTPUT_data : out STD_LOGIC_VECTOR(7 downto 0) -- Données de sortie A (8 bits)
    );
end component;    

component MemoireInstructions is
    Port (
        ADDR2        : in  STD_LOGIC_VECTOR(7 downto 0); -- Adresse de lecture A (4 bits)
        CLK         : in  STD_LOGIC;             -- Horloge
        OUTPUT_data : out STD_LOGIC_VECTOR(31 downto 0) -- Données de sortie A (8 bits)
    );
end component; 
    
    
    
begin
    process
    begin
        wait until rising_edge(CLK);
        if RST = '1' then
            registers <= (others => (others => '0')); -- Reset à 0x00 pour tous les registres
        elsif RST = '0' then
            if RW = '0' then
                registers(to_integer(unsigned(ADDR))) <= DATA; -- Écriture des données
            end if;
        end if;
    end process;
    
    OUTPUT_data <= registers(to_integer(unsigned(ADDR)));
    
end Behavioral1;

architecture Behavioral2 of BancMemoire is
    type reg_array is array (255 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- Initialisé à 0
    
begin
    process
    begin
        wait until rising_edge(CLK);
        OUTPUT_inst <= registers(to_integer(unsigned(ADDR)));
    end process;
    
    
    
end Behavioral2;
