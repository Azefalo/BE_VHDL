--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_DATA_Flow is

end test_DATA_Flow;

architecture Behavioral of test_DATA_Flow is

    component DATA_Flow is
        Port(
                RESET, CLK : in std_logic;
                ADD_INSTRU : in std_logic_vector(7 downto 0)
        );
    end component;
    
    signal RESET : std_logic := '0';
    signal CLK : std_logic := '0';
    signal ADD : std_logic_vector(7 downto 0) := (others=>'0');
    signal COUTER : integer := 0;
    
begin

        CPU_test : DATA_Flow PORT MAP(RESET,CLK,ADD);
        
        RESET <= '1' after 20 ns;
        
        process
        begin
            CLK <= NOT(CLK);
            wait for 10 ns;
        end process;
        
        process
        begin
            wait until rising_edge(CLK);
            COUTER <= COUTER + 1;
            if (COUTER >= 10) then   
                ADD <= ADD +'1';
                COUTER <= 0;
            end if;
        end process;

end Behavioral;
