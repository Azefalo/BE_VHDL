--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity RegistreBank is
    Port (  ADDR_A : in  STD_LOGIC_VECTOR(3 downto 0); -- Read address A (4 bits)
            ADDR_B : in  STD_LOGIC_VECTOR(3 downto 0); -- Read address B (4 bits)
            ADDR_W : in  STD_LOGIC_VECTOR(3 downto 0); -- Write address (4 bits)
            W      : in  STD_LOGIC;             -- Write enable signal active high
            DATA   : in  STD_LOGIC_VECTOR(7 downto 0); -- Input data (8 bits)
            RST    : in  STD_LOGIC;             -- Reset active low
            CLK    : in  STD_LOGIC;             -- Clock
            QA     : out STD_LOGIC_VECTOR(7 downto 0); -- Output data A (8 bits)
            QB     : out STD_LOGIC_VECTOR(7 downto 0)  -- Output data B (8 bits)
    );
end RegistreBank;

architecture Behavioral of RegistreBank is
    type reg_array is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 16 registers of 8 bits
    signal registers : reg_array;

begin
    process
    begin
        wait until rising_edge(CLK);
        if RST = '0' then
           registers <= (others => "00000000"); -- Reset to 0x00 for all registers
        elsif W = '1' then
            registers(conv_integer(unsigned(ADDR_W))) <= DATA; -- Write data
        end if;
    end process;

    -- Simultaneous read
    QA <= DATA when (ADDR_A = ADDR_W and W = '1') else
        registers(conv_integer(unsigned(ADDR_A))); 
    QB <= DATA when (ADDR_B = ADDR_W and W = '1') else
        registers(conv_integer(unsigned(ADDR_B)));

end Behavioral;
