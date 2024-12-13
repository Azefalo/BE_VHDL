--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Flip_Flop_D is

    Port (  OP_in    : in  STD_LOGIC_VECTOR (7 downto 0);
            A_in     : in  STD_LOGIC_VECTOR (7 downto 0);
            B_in     : in  STD_LOGIC_VECTOR (7 downto 0);
            C_in     : in  STD_LOGIC_VECTOR (7 downto 0);
           OP_out   : out STD_LOGIC_VECTOR (7 downto 0);
            A_out    : out STD_LOGIC_VECTOR (7 downto 0);
            B_out    : out STD_LOGIC_VECTOR (7 downto 0);
            C_out    : out STD_LOGIC_VECTOR (7 downto 0);
            RST      : in  STD_LOGIC;
            CLK      : in  STD_LOGIC
    );
           
end Flip_Flop_D;

architecture Behavioral of Flip_Flop_D is

begin
    process
    begin
        wait until(rising_edge(CLK));
        if RST = '0' then
            A_out  <= (others => '0');
            B_out  <= (others => '0');
            C_out  <= (others => '0');
            OP_out <= (others => '0');
        else
            A_out  <=  A_in;
            B_out  <=  B_in;
            C_out  <=  C_in;
            OP_out <=  OP_in;
        end if;
     end process;

end Behavioral;
