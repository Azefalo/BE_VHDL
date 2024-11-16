--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memDonnees_test is
end memDonnees_test;

architecture Behavioral of memDonnees_test is
    
    
    signal addr_in      : STD_LOGIC_VECTOR(7 downto 0);
    signal RW_in        : STD_LOGIC;
    signal rst_in       : STD_LOGIC;
    signal clk_in       : STD_LOGIC := '0';
    signal Data_in      : STD_LOGIC_VECTOR(7 downto 0);
    signal Output_out   : STD_LOGIC_VECTOR(7 downto 0);
   

component memDonnees is

    Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
           Data     : in STD_LOGIC_VECTOR (7 downto 0);
           RW       : in STD_LOGIC;
           RST      : in STD_LOGIC;
           CLK      : in STD_LOGIC;
           Output   : out STD_LOGIC_VECTOR (7 downto 0));
           
end component;


begin
        VHDL : memDonnees
        Port map (
        addr    => addr_in,
        RW      => RW_in,
        Data    => Data_in,
        RST     => rst_in,
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
        
        rst_in     <= '0';
        wait for 100 ns;
        
        rst_in     <= '1';
        RW_in       <= '0';
        addr_in   <= "00000010";       
        Data_in    <= "00001100";  --0c
        wait for 100 ns;
        
        --RW_in       <= '0';
        addr_in   <= "00000100";
        wait for 10 ns;       
        Data_in    <= "00000101";  --05
        wait for 100 ns;
        
        RW_in       <= '1';          
        addr_in   <= "00000010";  -- Res = 0c       
        wait for 100 ns;
        
        --RW_in       <= '1';          
        addr_in   <= "00000100";       -- Res = 05
        wait for 100 ns;
        
        wait;
        
        
end process;
end Behavioral;




