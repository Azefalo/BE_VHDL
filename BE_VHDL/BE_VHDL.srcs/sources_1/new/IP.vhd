--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity IP is
--    Port ( CLK : in STD_LOGIC;
--           RST : in STD_LOGIC;
--           D_out : out STD_LOGIC_VECTOR (7 downto 0));
--end IP;

--architecture Behavioral of IP is
--    signal Auxiliaire: unsigned(7 downto 0) := (others => '0'); -- Usar unsigned para operações
--    signal counting_up: boolean := true; -- Sinal que controla a contagem
--begin
--    process(CLK)
--    begin
--        if rising_edge(CLK) then
--            if (RST = '0') then
--                Auxiliaire <= (others => '0'); -- Resetar o contador
--                counting_up <= true; -- Começa a contar para cima
--            else
--                if counting_up then
--                    if Auxiliaire = "11111111" then -- Se o contador chegar a 255
--                        counting_up <= false; -- Muda para contagem para baixo
--                    else
--                        Auxiliaire <= Auxiliaire + 1; -- Incrementa o contador
--                    end if;
--                else
--                    if Auxiliaire = "00000000" then -- Se o contador chegar a 0
--                        counting_up <= true; -- Muda para contagem para cima
--                    else
--                        Auxiliaire <= Auxiliaire - 1; -- Decrementa o contador
--                    end if;
--                end if;
--            end if;
--        end if;
--    end process;

--    D_out <= std_logic_vector(Auxiliaire); -- Converter para std_logic_vector

--end Behavioral;

entity IP is
    Port ( CLK      : in    STD_LOGIC;
           RST      : in    STD_LOGIC;
           D_out    : out   STD_LOGIC_VECTOR (7 downto 0));
end IP;

architecture Behavioral of IP is
signal temporary_output : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');  -- Temporary Output and sets it to 0
	begin
        process
        begin
            wait until rising_edge(CLK);
            if RST = '0' then temporary_output <= (others => '0');
            else
              temporary_output <= temporary_output + 1;
            end if;
        end process;
        D_out <= temporary_output;
end architecture;