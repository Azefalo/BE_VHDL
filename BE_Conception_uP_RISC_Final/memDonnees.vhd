--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL; 
use IEEE.std_logic_unsigned.ALL; 

entity memDonnees is
    Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
           Data     : in STD_LOGIC_VECTOR (7 downto 0);
           Output   : out STD_LOGIC_VECTOR (7 downto 0);
           RW       : in STD_LOGIC;
           RST      : in STD_LOGIC;
           CLK      : in STD_LOGIC
    );
end memDonnees;

architecture Behavioral of memDonnees is

    type reg_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0); -- 256 registers of 8 bits
    signal Memoire : reg_array;

begin
    process
    begin
        wait until falling_edge(CLK);
        if RST = '0' then
            Memoire <= (others => (others => '0')); -- Reset to 0x00 for all registers
            Output <= x"00";
        elsif RW = '0' then
            Memoire(conv_integer(addr)) <= Data; -- Write data
            Output <= x"00";
        elsif RW = '1' then
            Output <= Memoire(conv_integer(addr)); -- Read data
        end if;
    end process;

end Behavioral;