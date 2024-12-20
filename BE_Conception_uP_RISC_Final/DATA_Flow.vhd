--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--  
--  Authors: Giovanna GRIGOLON, Joao Gabriel ALBUQUERQUE, 
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DATA_Flow is
    Port(
            RESET, CLK : in STD_LOGIC;
            ADD_INSTRU : in STD_LOGIC_VECTOR(7 downto 0));
end DATA_Flow;

architecture Behavioral of DATA_Flow is

    component ALU is
        Port(   A           : in  STD_LOGIC_VECTOR(7 downto 0);
                B           : in  STD_LOGIC_VECTOR(7 downto 0);
                Ctrl_Alu    : in  STD_LOGIC_VECTOR(2 downto 0);
                res         : out STD_LOGIC_VECTOR(7 downto 0);
                C           : out STD_LOGIC;
                O           : out STD_LOGIC;
                N           : out STD_LOGIC);
    end component;
    
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

    component Flip_Flop_D is
        Port (  OP_in    : in  STD_LOGIC_VECTOR (7 downto 0);
                A_in     : in  STD_LOGIC_VECTOR (7 downto 0);
                B_in     : in  STD_LOGIC_VECTOR (7 downto 0);
                C_in     : in  STD_LOGIC_VECTOR (7 downto 0);
                OP_out   : out STD_LOGIC_VECTOR (7 downto 0);
                A_out    : out STD_LOGIC_VECTOR (7 downto 0);
                B_out    : out STD_LOGIC_VECTOR (7 downto 0);
                C_out    : out STD_LOGIC_VECTOR (7 downto 0);
                RST      : in  STD_LOGIC;
                CLK      : in  STD_LOGIC);
    end component;

    component memDonnees is
        Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
               Data     : in STD_LOGIC_VECTOR (7 downto 0);
               Output   : out STD_LOGIC_VECTOR (7 downto 0);
               RW       : in STD_LOGIC;
               RST      : in STD_LOGIC;
               CLK      : in STD_LOGIC);
    end component;
    
    component memInstru is
        Port ( addr     : in STD_LOGIC_VECTOR (7 downto 0);
               CLK      : in STD_LOGIC;
               Output   : out STD_LOGIC_VECTOR (31 downto 0));
    end component;


    signal NONE                            : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); -- No data

    signal OP_DI, OP_EX, OP_MEM, OP_RE     : STD_LOGIC_VECTOR(7 downto 0); -- OP
    signal A_DI, A_EX, A_MEM, A_RE         : STD_LOGIC_VECTOR(7 downto 0); -- A
    signal B_LIDI, B_DIEX, B_DI, B_EX,
           B_MEM, B_MEMRE, B_RE            : STD_LOGIC_VECTOR(7 downto 0); -- B
    signal C_DI, C_EX                      : STD_LOGIC_VECTOR(7 downto 0); -- C
    
    signal CURRENT_INST                    : STD_LOGIC_VECTOR(31 downto 0); -- Current instruction

    signal QA, QB                          : STD_LOGIC_VECTOR(7 downto 0); -- Data from registers
    signal W_RE                            : STD_LOGIC; -- Write signal
    signal RW                              : STD_LOGIC; -- Read/Write signal
    
    signal CONTROL_ALU                     : STD_LOGIC_VECTOR(2 downto 0); -- Control signal for ALU
    signal OUT_ALU                         : STD_LOGIC_VECTOR(7 downto 0); -- Data from ALU

    signal OUT_memDonnes                   : STD_LOGIC_VECTOR(7 downto 0); -- Data from memory
    signal ADDR_memDonnes                  : STD_LOGIC_VECTOR(7 downto 0); -- Address for memory
    
begin
    MEM_INSTRU : memInstru PORT MAP (   addr    => ADD_INSTRU,
                                        CLK     => CLK,
                                        Output  => CURRENT_INST);
    
    LI_DI : Flip_Flop_D PORT MAP(   OP_in   => CURRENT_INST(31 downto 24),
                                    A_in    => CURRENT_INST(23 downto 16),
                                    B_in    => CURRENT_INST(15 downto 8),
                                    C_in    => CURRENT_INST(7 downto 0),
                                    OP_out  => OP_DI,
                                    A_out   => A_DI,
                                    B_out   => B_LIDI,
                                    C_out   => C_DI,
                                    RST     => reset,
                                    CLK     => CLK);
                                        
    BANC_REGISTRES : RegistreBank PORT MAP (    ADDR_A => B_LIDI(3 downto 0),
                                                ADDR_B => C_DI(3 downto 0),
                                                ADDR_W => A_RE(3 downto 0),
                                                W      => W_RE,
                                                DATA   => B_RE,
                                                RST    => reset,
                                                CLK    => CLK,
                                                QA     => QA,
                                                QB     => QB);
    
    DI_EX : Flip_Flop_D PORT MAP(   OP_in   => OP_DI,
                                    A_in    => A_DI,
                                    B_in    => B_DIEX,
                                    C_in    => QB,
                                    OP_out  => OP_EX,
                                    A_out   => A_EX,
                                    B_out   => B_DI,
                                    C_out   => C_EX,
                                    RST     => reset,
                                    CLK     => CLK);
    
    ALU1 : ALU PORT MAP (   A            => B_DI,
                            B            => C_EX,
                            Ctrl_Alu     => CONTROL_ALU,
                            res          => OUT_ALU,
                            C            => OPEN,
                            O            => OPEN,
                            N            => OPEN);
    
    EX_MEM : Flip_Flop_D PORT MAP(  OP_in   => OP_EX,
                                    A_in    => A_EX,
                                    B_in    => B_EX,
                                    C_in    => NONE,
                                    OP_out  => OP_MEM,
                                    A_out   => A_MEM,
                                    B_out   => B_MEM,
                                    C_out   => OPEN,
                                    RST     => reset,
                                    CLK     => CLK);
    
    MEM_DONNEES : memDonnees PORT MAP (    addr    => ADDR_memDonnes,
                                           Data    => B_MEM,
                                           Output  => OUT_memDonnes,
                                           RW      => RW,
                                           RST     => reset,
                                           CLK     => CLK);
    
    MEM_RE : Flip_Flop_D PORT MAP(  OP_in   => OP_MEM,
                                    A_in    => A_MEM,
                                    B_in    => B_MEMRE,
                                    C_in    => NONE,
                                    OP_out  => OP_RE,
                                    A_out   => A_RE,
                                    B_out   => B_RE,
                                    C_out   => OPEN,
                                    RST     => reset,
                                    CLK     => CLK);
  

                            -- DI LEVEL --
    
    MUX_DI : process 
        begin
            wait until falling_edge(CLK);
            if OP_DI = x"06" then           -- AFC    
                B_DIEX <= B_LIDI;
            elsif OP_DI = x"07" then        -- LOAD
                B_DIEX <= B_LIDI;
            elsif OP_DI = x"00" then        -- NOP
                B_DIEX <= (others => '0');
            else                            -- ADD,MUL,SOU,COP,STORE
                B_DIEX <= QA;
            end if;
    end process MUX_DI;

   
                           -- EX LEVEL --
    
    EX : process 
        begin
            wait until falling_edge(CLK);
            if OP_EX = x"01" then           -- ADD
                CONTROL_ALU <= "000";
             B_EX <= OUT_ALU;
            elsif OP_EX = x"02" then        -- MUL
                CONTROL_ALU <= "111";
             B_EX <= OUT_ALU;
            elsif OP_EX = x"03" then        -- SOU
                CONTROL_ALU <= "001";
             B_EX <= OUT_ALU;
            else                            -- COP
                CONTROL_ALU <= "101"; 
             B_EX <= B_DI;
            end if;             
    end process EX;
    

                            -- MEM LEVEL --
    
    MUX_EX_MEM : process
        begin
            wait until falling_edge(CLK);
            -- 1st MUX
            if OP_MEM = x"08" then          -- STORE
                ADDR_memDonnes <= A_MEM;
            elsif OP_MEM = x"07" then       -- LOAD
                ADDR_memDonnes <= B_MEM;
            else
                ADDR_memDonnes <= NONE;
            end if;
            -- 2nd MUX
            if OP_MEM = x"07" then           -- LOAD   
                B_MEMRE <= OUT_memDonnes;            
            else
                B_MEMRE <= B_MEM;                    
            end if;
    end process MUX_EX_MEM;
    
    RW <= '0' when OP_MEM = x"08" else '1';

    
                               -- RE LEVEL --
    
    W_RE <= '0' when OP_RE = x"08" else '1';    -- Write to R1 except in the case of STORE
    

end Behavioral;
