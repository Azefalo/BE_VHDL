--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memInstru_test is
end memInstru_test;

architecture Behavioral of memInstru_test is
    
    
    signal addr_in      : STD_LOGIC_VECTOR(7 downto 0);
    signal clk_in       : STD_LOGIC := '0';
    signal Output_out   : STD_LOGIC_VECTOR(31 downto 0);
   

component memInstru is

    Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
           CLK      : in STD_LOGIC;
           Output   : out STD_LOGIC_VECTOR (31 downto 0));
           
end component;


begin
        VHDL : memInstru
        Port map (
        addr    => addr_in,
        CLK     => clk_in,
        Output  => Output_out
        );
        
clk_process : process
begin
    CLK_in <= '0';
    wait for 0.5 ns;
    CLK_in <= '1';
    wait for 0.5 ns;
end process;
        
process
begin
        
        addr_in   <= x"FF";       
        wait for 100 ns;
        
        addr_in   <= x"01";       
        wait for 100 ns;
        
        addr_in   <= "00011010";       
        wait for 100 ns;

        wait;
        
        
end process;
end Behavioral;




