--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_RegistreBank is
end test_RegistreBank;

architecture Beh of test_RegistreBank is

    component RegistreBank is 
        Port (  ADDR_A : in  STD_LOGIC_VECTOR(3 downto 0); 
                ADDR_B : in  STD_LOGIC_VECTOR(3 downto 0);
                ADDR_W : in  STD_LOGIC_VECTOR(3 downto 0);
                W      : in  STD_LOGIC; 
                DATA   : in  STD_LOGIC_VECTOR(7 downto 0);
                RST    : in  STD_LOGIC;
                CLK    : in  STD_LOGIC;
                QA     : out STD_LOGIC_VECTOR(7 downto 0);
                QB     : out STD_LOGIC_VECTOR(7 downto 0));
    end component; 
    
    For all : RegistreBank use entity work.RegistreBank(beh);
    
    --input 
    signal ADDR_A, ADDR_B, ADDR_W : std_logic_vector (3 downto 0); 
    signal W, RST   : std_logic; 
    signal CLK      : std_logic := '0'; 
    signal DATA     : std_logic_vector (7 downto 0); 
    
    --output 
    signal lu1, lu2 : std_logic_vector (7 downto 0); 
    
begin
    BancDeRegistre : RegistreBank port map (ADDR_A, ADDR_B, ADDR_W, W, DATA, RST, CLK, lu1, lu2); 
    
    process
    begin
        RST<='0';
        ADDR_A <= conv_std_logic_vector(0,4);
        ADDR_B <= conv_std_logic_vector(0,4);
        ADDR_W <= conv_std_logic_vector(0,4);
        W <= '0';
        DATA <= "00000000";
        
        wait for 10 ns;
       
        RST<='1';
        W <='1'; -- Write values into the registers
        for num_reg in 0 to 15 loop
            ADDR_W  <= conv_std_logic_vector(num_reg,4);
            DATA    <= DATA + '1';   
            wait for 10 ns;            
        end loop;
            
        wait for 10 ns;
        
        W <= '0'; -- Read the registers
        for num_reg in 0 to 15 loop
            ADDR_A <= conv_std_logic_vector(num_reg,4);
            ADDR_B <= conv_std_logic_vector(num_reg,4);
            wait for 10 ns;
        end loop;
        
        wait for 10 ns;
        RST<='0';
        wait for 10 ns;
        RST <='1'; 
        W <='0'; -- Write values into the registers but with W at 0
        for num_reg in 0 to 15 loop
            ADDR_W  <= conv_std_logic_vector(num_reg,4);
            DATA    <= DATA + '1';       
            wait for 10 ns;        
        end loop;
        
        wait for 10 ns;
        
        for num_reg in 0 to 15 loop -- Check the reset and W
            ADDR_A <= conv_std_logic_vector(num_reg,4);
            ADDR_B <= conv_std_logic_vector(num_reg,4);
            wait for 10 ns;
        end loop;  
   end process;
   
   -- Clock generation 
   process
   begin
      CLK <= NOT(CLK);
      wait for 1 ns; 
   end process;

end Beh;