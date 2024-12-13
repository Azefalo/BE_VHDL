--------------------------------------------------------------------------------------------
--  
--  BE VHDL 
--  INSA TOULOUSE
--------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity ALU is
    Port(
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
    -- Perform arithmetic and logic operations
    r_add <= (x"00" & A) + (x"00" & B);  -- Addition
    r_sub <= (x"00" & A) - (x"00" & B);  -- Subtraction
    r_mul <= (A *  B);                   -- Multiplication
    r_and <= (x"00" & A)AND(x"00" & B);  -- Bitwise AND
    r_or  <= (x"00" & A)OR (x"00" & B);  -- Bitwise OR
    r_xor <= (x"00" & A)XOR(x"00" & B);  -- Bitwise XOR
    r_nota <= NOT(x"00" & A);            -- Bitwise NOT on A
    r_notb <= NOT(x"00" & B);            -- Bitwise NOT on B

    -- Select the operation result based on Ctrl_Alu
    tmp <=  r_add  when Ctrl_Alu = "000" else
            r_sub  when Ctrl_Alu = "001" else
            r_mul  when Ctrl_Alu = "010" else
            r_and  when Ctrl_Alu = "011" else
            r_or   when Ctrl_Alu = "100" else
            r_xor  when Ctrl_Alu = "101" else
            r_nota when Ctrl_Alu = "110" else
            r_mul;                              -- For some reason if this isn't here, the multiplication doesn't work

    -- Assign the lower 8 bits of the result to the output
    res <= tmp(7 downto 0);

    -- Set the flags based on the result
    C   <= r_add(8);  -- Carry flag for addition
    O   <= '1' when r_mul(15 downto 8) /= x"00" else '0'; -- Overflow flag for multiplication
    N   <= tmp(15);  -- Negative flag

end architecture;
