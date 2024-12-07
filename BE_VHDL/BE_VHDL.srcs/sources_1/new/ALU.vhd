--------------------------------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity ALU is
    port(
        -- Inputs
        A           : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input A                 (8 bits) |7|6|5|4|3|2|1|0|
        B           : in  STD_LOGIC_VECTOR(7 downto 0);   -- Input B                 (8 bits) |7|6|5|4|3|2|1|0|
        Ctrl_Alu    : in  STD_LOGIC_VECTOR(2 downto 0);   -- Code for the operation  (3 bits) |2|1|0|
        -- Outputs
        res         : out STD_LOGIC_VECTOR(7 downto 0);   -- Result of the operation (8 bits) |7|6|5|4|3|2|1|0|
        -- Flags
        C           : out STD_LOGIC;                      -- Flag: Carry            (LOGIC: True or False)
        O           : out STD_LOGIC;                      -- Flag: Overflow         (LOGIC: True or False)
        N           : out STD_LOGIC                       -- Flag: Negative result  (LOGIC: True or False)
    );
end entity;

architecture Behavioral of ALU is
    signal 	tmp 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
	signal 	r_add 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
	signal 	r_sub 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
	signal 	r_mul 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
    signal 	r_and 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
    signal 	r_or 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
    signal 	r_xor 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
    signal 	r_nota 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits
    signal 	r_notb 	: 	STD_LOGIC_VECTOR(15 downto 0); 	-- 16 bits

begin
    r_add <= (x"00" & a) + (x"00" & b);
    r_sub <= (x"00" & a) - (x"00" & b);
    r_mul <= (a) * (b);
    r_and <= (x"00" & a) and (x"00" & b);
    r_or  <= (x"00" & a) or (x"00" & b);
    r_xor <= (x"00" & a) xor (x"00" & b);
    r_nota <= not (x"00" & a);
    r_notb <= not (x"00" & b);


    tmp <=  r_add  when Ctrl_Alu = "000" else
            r_sub  when Ctrl_Alu = "001" else
            r_mul  when Ctrl_Alu = "010" else
            r_and  when Ctrl_Alu = "011" else
            r_or   when Ctrl_Alu = "100" else
            r_xor  when Ctrl_Alu = "101" else
            r_nota when Ctrl_Alu = "110" else
            r_notb;

    res <= tmp(7 downto 0);
    C   <= r_add(8);
    O   <= '1' when r_mul(15 downto 8) /= x"00" else '0';
    N   <= tmp(15);

end architecture;
