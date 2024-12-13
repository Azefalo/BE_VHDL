--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Ilustration2 is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end Ilustration2;

architecture Behavioral of Ilustration2 is
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
    
    component UAL is
        Port(   A           : in  STD_LOGIC_VECTOR(7 downto 0);
                B           : in  STD_LOGIC_VECTOR(7 downto 0);
                Ctrl_Alu    : in  STD_LOGIC_VECTOR(2 downto 0);
                res         : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component LC_OP_RE is
        Port (  OP : in STD_LOGIC_VECTOR (7 downto 0);
                W : out STD_LOGIC);
    end component;
    
    component LC_OP_MD is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           RW : out STD_LOGIC);
    end component;

    component LC_OP_UAL is
    Port ( OP : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    component MUX_BR is
        Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
               OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component MUX_UAL is
        Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
               OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component MUX_MD1 is
        Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
               OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component MUX_MD2 is
        Port ( OP       : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT1   : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT2   : in STD_LOGIC_VECTOR (7 downto 0);
               OUTPUT   : out STD_LOGIC_VECTOR (7 downto 0));
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
    
    component memDonnees is
        Port ( addr     : in STD_LOGIC_VECTOR (3 downto 0);
               Data     : in STD_LOGIC_VECTOR (7 downto 0);
               RW       : in STD_LOGIC;
               RST      : in STD_LOGIC;
               CLK      : in STD_LOGIC;
               Output   : out STD_LOGIC_VECTOR (7 downto 0));
end component;
    
    signal IP_memInstru             : STD_LOGIC_VECTOR(7 downto 0);
    signal memInstru_LiDi           : STD_LOGIC_VECTOR(31 downto 0);
    signal A_LiDi                   : STD_LOGIC_VECTOR(7 downto 0);
    signal B_LiDi                   : STD_LOGIC_VECTOR(7 downto 0);
    signal C_LiDi                   : STD_LOGIC_VECTOR(7 downto 0);
    signal OP_LiDi                  : STD_LOGIC_VECTOR(7 downto 0);
    signal QA_RegistreBank_BR       : STD_LOGIC_VECTOR(7 downto 0);
    signal Output_MUX_BR            : STD_LOGIC_VECTOR(7 downto 0);
    signal B_RegistreBank_Out_DiEx  : STD_LOGIC_VECTOR(7 downto 0);
    signal B_Mem_RE_DATA            : STD_LOGIC_VECTOR(7 downto 0);
    signal A_DiEx                   : STD_LOGIC_VECTOR(7 downto 0);
    signal B_DiEx                   : STD_LOGIC_VECTOR(7 downto 0);
    signal C_DiEx                   : STD_LOGIC_VECTOR(7 downto 0);
    signal OP_DiEx                  : STD_LOGIC_VECTOR(7 downto 0);
    signal signal_LC_OP_UAL         : STD_LOGIC_VECTOR(2 downto 0);
    signal Output_UAL               : STD_LOGIC_VECTOR(7 downto 0);
    signal Output_MUX_UAL           : STD_LOGIC_VECTOR(7 downto 0);
    signal A_ExMem                  : STD_LOGIC_VECTOR(7 downto 0);
    signal B_ExMem                  : STD_LOGIC_VECTOR(7 downto 0);
    signal C_ExMem                  : STD_LOGIC_VECTOR(7 downto 0);
    signal OP_ExMem                 : STD_LOGIC_VECTOR(7 downto 0);
    signal Output_MUX1_MD           : STD_LOGIC_VECTOR(7 downto 0);
    signal signal_LC_OP_MD          : STD_LOGIC;
    signal Output_MUX2_MD           : STD_LOGIC_VECTOR(7 downto 0);
    signal Output_MD                : STD_LOGIC_VECTOR(7 downto 0);
    signal A_MemRe                  : STD_LOGIC_VECTOR(7 downto 0);
    signal B_MemRe                  : STD_LOGIC_VECTOR(7 downto 0);
    signal C_MemRe                  : STD_LOGIC_VECTOR(7 downto 0);
    signal OP_MemRe                 : STD_LOGIC_VECTOR(7 downto 0);
    signal LC_OP_RE_W               : STD_LOGIC;
    signal None_signal              : STD_LOGIC_VECTOR(7 downto 0) := (others => 'X');
    

begin  

    U1 : IP Port map(   CLK     => CLK,
                        RST     => RST, 
                        D_out   => IP_memInstru);
    
    U2 : memInstru  Port map (  CLK     => CLK,
                                addr    => IP_memInstru, 
                                Output  => memInstru_LiDi);
                       
    U3 : Flip_Flop_D Port map ( OP_in   => memInstru_LiDi(31 downto 24),
                                A_in    => memInstru_LiDi(23 downto 16),    -- [Ri] â†? [Rj] + [Rk]   page 03
                                B_in    => memInstru_LiDi(15 downto 8),
                                C_in    => memInstru_LiDi(7 downto 0),
                                CLK     => CLK,
                                A_out   => A_LiDi,
                                B_out   => B_LiDi,
                                C_out   => C_LiDi,
                                OP_out  => OP_LiDi);
                              
    U4: RegistreBank Port map ( ADDR_A  => B_LiDi(3 downto 0),
                                ADDR_B  => C_LiDi(3 downto 0),
                                ADDR_W  => A_LiDi(3 downto 0),
                                W       => LC_OP_RE_W,
                                DATA    => B_Mem_RE_DATA,
                                RST     => RST,
                                CLK     => CLK,
                                QA      => QA_RegistreBank_BR,
                                QB      => B_RegistreBank_Out_DiEx);
                                
    U5 : MUX_BR Port map (  OP      => OP_LiDi,
                            INPUT1  => B_LiDi,
                            INPUT2  => QA_RegistreBank_BR,
                            OUTPUT  => Output_MUX_BR);
                               
    U6 : Flip_Flop_D Port map ( A_in    => A_LiDi,
                                B_in    => Output_MUX_BR,
                                C_in    => B_RegistreBank_Out_DiEx,
                                OP_in   => OP_LiDi,
                                CLK     => CLK,
                                A_out   => A_DiEx,
                                B_out   => B_DiEx,
                                C_out   => C_DiEx,
                                OP_out  => OP_DiEx);
                                
    U7 : LC_OP_UAL Port map (    OP          => OP_DiEx,
                                Ctrl_Alu     => signal_LC_OP_UAL );
    
    U8 : UAL Port map (     A           => B_DiEx,
                            B           => C_DiEx,
                            Ctrl_Alu    => signal_LC_OP_UAL,
                            res         => Output_UAL);
    
    U9 : MUX_UAL Port map ( OP      => OP_DiEx,
                            INPUT1  => B_DiEx,
                            INPUT2  => Output_UAL,
                            OUTPUT  => Output_MUX_UAL);
    
    U10 : Flip_Flop_D Port map (    A_in   => A_DiEx,
                                    B_in    => Output_MUX_UAL,
                                    C_in    => None_signal,
                                    OP_in   => OP_DiEx,
                                    CLK     => CLK,
                                    A_out   => A_ExMem,
                                    B_out   => B_ExMem,
                                    C_out   => C_ExMem,
                                    OP_out  => OP_ExMem);
                               
    U11 : MUX_MD1 Port map (    OP      => OP_ExMem,
                                INPUT1  => A_ExMem,
                                INPUT2  => B_ExMem,
                                OUTPUT  => Output_MUX1_MD);
                            
    U12 : LC_OP_MD Port map (   OP  => OP_ExMem,
                                RW  => signal_LC_OP_MD);
                                
    U13 : memDonnees Port map ( addr     => Output_MUX1_MD(3 downto 0),
                                Data     => B_ExMem,
                                RW       => signal_LC_OP_MD,
                                RST      => RST,
                                CLK      => CLK,
                                Output   => Output_MD);
     
     U14 : MUX_MD2 Port map (   OP      => OP_ExMem,
                                INPUT1  => Output_MD,
                                INPUT2  => B_ExMem,
                                OUTPUT  => Output_MUX2_MD);
                            
     U15 : Flip_Flop_D Port map (   A_in    => A_ExMem,
                                    B_in    => Output_MUX2_MD,
                                    C_in    => None_signal,
                                    OP_in   => OP_ExMem,
                                    CLK     => CLK,
                                    A_out   => A_MemRe,
                                    B_out   => B_MemRe,
                                    C_out   => C_MemRe,
                                    OP_out  => OP_MemRe);
                                
    U16: LC_OP_RE Port map(     OP  => OP_MemRe,
                                W   => LC_OP_RE_W);    


end Behavioral;
