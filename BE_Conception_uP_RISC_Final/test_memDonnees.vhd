--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_memDonnees is
end test_memDonnees;

architecture Beh of test_memDonnees is

    component memDonnees is
        Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
               Data     : in STD_LOGIC_VECTOR (7 downto 0);
               Output   : out STD_LOGIC_VECTOR (7 downto 0);
               RW       : in STD_LOGIC;
               RST      : in STD_LOGIC;
               CLK      : in STD_LOGIC
        );
    end component;
        
    signal addr, Data_IN    : std_logic_vector (7 downto 0); 
    signal Output_OUT       : std_logic_vector (7 downto 0); 
    signal RW, RST          : std_logic; 
    signal CLK              : std_logic := '0'; 
    
begin
    memDonnes_under_test: memDonnees port map (addr, Data_IN, Output_OUT, RW, RST, CLK); 
     
    process
    begin
        RST     <= '0';
        addr    <= conv_std_logic_vector(0, 8);
        Data_IN <= conv_std_logic_vector(0, 8);
        RW <= '0';
        
        wait for 10 ns;
        
        RST     <= '1';
        RW      <= '0'; -- to write
        addr    <= "00000000";
        Data_IN <= "10101010";
        
        wait for 10 ns;
        
        addr    <= "11111111";
        Data_IN <= "01010101";
        
        wait for 10 ns;
        
        RW      <= '1'; -- to read
        addr    <= "00000000";
        
        wait for 10 ns;

        addr    <= "11111111";

        wait for 10 ns;
        
        RST     <= '0';
        
        wait for 10 ns;

        RST     <= '1';
        addr    <= "00000000";
        
        wait for 10 ns;

        addr    <= "11111111";
        
        wait for 10 ns;     
            
    end process;
    
-- Clock generation
   process
   begin
      CLK <= NOT(CLK);
      wait for 1 ns; 
   end process;

end Beh;
