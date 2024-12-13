--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IP is
    Port ( CLK      : in    STD_LOGIC;
           RST      : in    STD_LOGIC;
           D_out    : out   STD_LOGIC_VECTOR (7 downto 0));
end IP;

architecture Behavioral of IP is
signal temporary_output : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');  -- Temporary Output and sets it to 0
	begin
        process
        begin
            wait until rising_edge(CLK);
            if RST = '0' then temporary_output <= (others => '0');
            else
              temporary_output <= temporary_output + 1;
            end if;
        end process;
        D_out <= temporary_output;
end architecture;