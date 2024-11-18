--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistreBank_test is
end RegistreBank_test;
architecture Behavioral of RegistreBank_test is
    
    
    signal addrA_in : STD_LOGIC_VECTOR(3 downto 0);
    signal addrB_in : STD_LOGIC_VECTOR(3 downto 0);
    signal addrW_in : STD_LOGIC_VECTOR(3 downto 0);
    signal W_in     : STD_LOGIC;
    signal rst_in   : STD_LOGIC;
    signal clk_in   : STD_LOGIC := '0';
    signal Data_in  : STD_LOGIC_VECTOR(7 downto 0);
    signal A_out    : STD_LOGIC_VECTOR(7 downto 0);
    signal B_out    : STD_LOGIC_VECTOR(7 downto 0);
    
    
component RegistreBank is
    
    
    Port (
        ADDR_A : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse de lecture A (4 bits)
        ADDR_B : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse de lecture B (4 bits)
        ADDR_W : in  STD_LOGIC_VECTOR(3 downto 0); -- Adresse d'écriture (4 bits)
        W      : in  STD_LOGIC;             -- Signal d'écriture actif à 1
        DATA   : in  STD_LOGIC_VECTOR(7 downto 0); -- Données d'entrée (8 bits)
        RST    : in  STD_LOGIC;             -- Reset actif à 0
        CLK    : in  STD_LOGIC;             -- Horloge
        QA     : out STD_LOGIC_VECTOR(7 downto 0); -- Données de sortie A (8 bits)
        QB     : out STD_LOGIC_VECTOR(7 downto 0)  -- Données de sortie B (8 bits)
    );
    
    
end component;
begin
        
        
        VHDL : RegistreBank
        Port map (
        ADDR_A  => addrA_in,
        ADDR_B  => addrB_in,
        ADDR_W  => addrW_in,
        W       => W_in,
        DATA    => Data_in,
        RST     => rst_in,
        CLK     => clk_in,
        QA      => A_out,
        QB      => B_out
        
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
        W_in       <= '1';
        addrW_in   <= "0010";       -- 2
        Data_in    <= "00001100";   -- 0d
        wait for 10 ns;
        
        --W_in       <= '1';
        addrW_in   <= "0100";       -- 4
        Data_in    <= "00001011";   -- 0c
        wait for 10 ns;
        
        W_in       <= '0';          
        addrA_in   <= "0010";       -- 0d
        wait for 10 ns;
        
        W_in       <= '0';          
        addrB_in   <= "0100";       -- 0c
        wait for 10 ns;
        
        -- bypass
        W_in       <= '1';
        addrW_in   <= "0011";       -- 
        addrA_in   <= "0011";       -- 
        DATA_in    <= "00000001";   -- 01
        wait for 10 ns;
        
        wait;
        
        
end process;
end Behavioral;
