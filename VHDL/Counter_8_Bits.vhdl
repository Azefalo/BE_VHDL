--------------------------------------------------------------------------------------------
-- Author: João Gabriel 
-- TD VHDL, INSA Toulouse
--
--	8 Bits Counter:
-- 	This VHDL code describes an 8-bit up/down counter with load and reset functionalities.
-- 	The counter operates based on the clock signal and can increment or decrement depending
-- 	on the SENS signal. When the LOAD signal is active, the counter loads a specified 8-bit
-- 	value (Din). The counter is enabled when EN is low, and resets when RST is asserted.
-- 	The result is output on Dout, and the counter increments or decrements based on the
-- 	SENS control signal.
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1964.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Counter_8_Bits is
    port(
        CK      :   in  STD_LOGIC;
        RST     :   in  STD_LOGIC;
        LOAD    :   in  STD_LOGIC;
        SENS    :   in  STD_LOGIC;
        EN      :   in  STD_LOGIC;
        Din     :   in  STD_LOGIC_VECTOR(7 downto 0);
        Dout    :   out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture Behavioral of Counter_8_Bits is
	signal temporary_output : STD_LOGIC_VECTOR(7 downto 0) <= (others => '0');  -- Temporary Output and sets it to 0
	begin
        process(RST, rising_edge(CLK))
        begin
            -- wait until rising_edge(CLK);
            if RST = '0' then temporary_output <= (others => '0');
            elsif LOAD = '1' then temporary_output <= Din;
            elsif EN = '0' then
                if      SENS = '1' then temporary_output <= aux + 1;
                elsif   SENS = '0' then temporary_output <= aux - 1;
                end if;
            -- Dout <= temporary_output;     NOT HERE because this makes it on clock late
            end if;
        end process;
        Dout <= temporary_output;
end architecture;
