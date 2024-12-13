--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ilustration1_test is

end Ilustration1_test;

architecture Behavioral of Ilustration1_test is
    -- Déclaration des signaux pour connecter �  l'UUT (Unit Under Test)
    signal CLK    : std_logic := '0';
    signal RST    : std_logic := '0';
    signal Output : std_logic_vector(7 downto 0);

    -- Constante pour définir la période de l'horloge
    constant CLK_PERIOD : time := 50 ns;
    
begin

        -- Génération de l'horloge (CLK)
    CLK_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Instanciation de l'entité CPU1best
        CPU1: entity work.Ilustration1
        port map (
            CLK    => CLK,
            RST    => RST,
            Output => Output
        );

    -- Génération des stimuli
    Stimulus_process : process
    begin
        -- Initialisation : appliquer une réinitialisation
        RST <= '1';
        wait for 80 ns;
        RST <= '0';

        -- Attendre quelques cycles pour observer les sorties
        wait for 100 ns;
        wait;
    end process;


end Behavioral;
