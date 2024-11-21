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
                OP_in   : in  STD_LOGIC_VECTOR (7 downto 0);
                CLK     : in  STD_LOGIC;
                A_out   : out STD_LOGIC_VECTOR (7 downto 0);
                B_out   : out STD_LOGIC_VECTOR (7 downto 0);
                C_out   : out STD_LOGIC_VECTOR (7 downto 0);
                OP_out  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component LC_OP_RE is
        Port (  OP : in STD_LOGIC_VECTOR (7 downto 0);
                W : out STD_LOGIC);
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
    signal memInstru_LiDi       : STD_LOGIC_VECTOR(31 downto 0);
    signal LiDi_A               : STD_LOGIC_VECTOR(7 downto 0);
    signal LiDi_B               : STD_LOGIC_VECTOR(7 downto 0);
    signal LiDi_C               : STD_LOGIC_VECTOR(7 downto 0);
    signal LiDi_OP              : STD_LOGIC_VECTOR(7 downto 0);
    signal LC_OP                : STD_LOGIC;
    signal addr_w_signal : STD_LOGIC_VECTOR(3 downto 0);
    type reg_array is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0); -- 16 registres de 8 bits
    signal registers : reg_array := (others => (others => '0')); -- InitialisÃ© Ã  0
    signal RegistreBank_Out     : STD_LOGIC_VECTOR(7 downto 0);
    signal None_signal          : STD_LOGIC_VECTOR(7 downto 0) := (others => 'X');

begin  
   registers(conv_integer(unsigned(addr_w_signal))) <= LiDi_A;

    U1 : IP Port map(   CLK     => CLK,
                        RST     => RST, 
                        D_out   => IP_memInstru);
    
    U2 : memInstru  Port map (  CLK     => CLK,
                                addr    => IP_memInstru  , 
                                Output  => memInstru_LiDi);
                       
    U3 : Flip_Flop_D Port map ( A_in    => memInstru_LiDi(31 downto 24),    -- [Ri] â†? [Rj] + [Rk]   page 03
                                B_in    => memInstru_LiDi(15 downto 8),
                                C_in    => memInstru_LiDi(7 downto 0),
                                OP_in   => memInstru_LiDi(23 downto 16),
                                CLK     => CLK,
                                A_out   => LiDi_A,
                                B_out   => LiDi_B,
                                C_out   => LiDi_C,
                                OP_out  => LiDi_OP);
    
    U4: LC_OP_RE Port map(  OP  => LiDi_OP,
                            W   => LC_OP);    
                                                    
    U5: RegistreBank Port map ( ADDR_A  => (others => 'X'),
                                ADDR_B  => (others => 'X'),
                                ADDR_W => addr_w_signal,
                                -- ADDR_W  => registers(to_integer(unsigned(LiDi_A))),
                                W       => LC_OP,
                                DATA    => LiDi_B,
                                RST     => RST,
                                CLK     => CLK,
                                QA      => Output,
                                QB      => None_signal);

end Behavioral;
