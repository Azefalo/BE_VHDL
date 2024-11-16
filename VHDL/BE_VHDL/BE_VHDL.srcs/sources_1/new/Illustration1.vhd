--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Illustration1 is
    Port (
       CLK      : in    std_logic;
       RST      : in    std_logic;
       Output   : out   STD_LOGIC_VECTOR(7 downto 0)
    );
end Illustration1;

architecture Behavioral of Illustration1 is
    component IP is
        Port(   CLK     : in    STD_LOGIC;
                RST     : in    STD_LOGIC;
                D_out   : out   STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component memInstru is
        Port (  addr    : in STD_LOGIC_VECTOR (7 downto 0);
                CLK     : in STD_LOGIC;
                Output  : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component Flip_Flop_D is
        Port (  A_in    : in  STD_LOGIC_VECTOR (7 downto 0);
                B_in    : in  STD_LOGIC_VECTOR (7 downto 0);
                C_in    : in  STD_LOGIC_VECTOR (7 downto 0);
                OP_in   : in  STD_LOGIC_VECTOR (3 downto 0);
                CLK     : in  STD_LOGIC;
                A_out   : out STD_LOGIC_VECTOR (7 downto 0);
                B_out   : out STD_LOGIC_VECTOR (7 downto 0);
                C_out   : out STD_LOGIC_VECTOR (7 downto 0);
                OP_out  : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component RegistreBank is
        Port (  ADDR_A  : in  STD_LOGIC_VECTOR(3 downto 0);
                ADDR_B  : in  STD_LOGIC_VECTOR(3 downto 0);
                ADDR_W  : in  STD_LOGIC_VECTOR(3 downto 0);
                W       : in  STD_LOGIC;    
                DATA    : in  STD_LOGIC_VECTOR(7 downto 0);
                RST     : in  STD_LOGIC;    
                CLK     : in  STD_LOGIC;   
                QA      : out STD_LOGIC_VECTOR(7 downto 0);
                QB      : out STD_LOGIC_VECTOR(7 downto 0));   
    end component;
    
    signal IP_memInstru         : STD_LOGIC_VECTOR(7 downto 0);
    signal memInstru_LiDi       : STD_LOGIC_VECTOR(7 downto 0);
    signal LiDi_RegistreBank    : STD_LOGIC_VECTOR(7 downto 0);
    signal RegistreBank_Out     : STD_LOGIC_VECTOR(7 downto 0);

begin  
   
    U1 : IP Port map(   CLK     => CLK,
                        RST     => RST, 
                        D_out   => IP_memInstru);
    
    U2 : memInstru  Port map (  CLK             => CLK,
                                IP_memInstru    => addr, 
                                Output          => memInstru_LiDi);
                       
    U3 : Flip_Flop_D Port map ( A_in    =>
                                B_in    =>
                                C_in    =>
                                OP_in   => 
                                CLK     => CLK,
                                A_out   =>
                                B_out   =>
                                C_out   =>
                                OP_out  =>      );

end Behavioral;
