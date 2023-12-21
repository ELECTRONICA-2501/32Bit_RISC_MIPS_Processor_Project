library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity InstructionMemory is
    Port ( Address : in STD_LOGIC_VECTOR (31 downto 0);
           Inst : out STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture Behavioral of InstructionMemory is
type mem16by32 is array (0 to 20) of std_logic_vector(31 downto 0);

signal InstMem: mem16by32 := (  x"8E4B009C",--10001110010010110000000010011100  -- 0x0000 03E8  --   lw $t3, 300($s2)
                                x"AEEE0120",--10101110111011100000000100100000  -- 0x0000 03EC  --   sw $t6, 400($s7)  
                                x"16CD00C8",--00010110110011010000000011001000  -- 0x0000 03F0  --   bne $s6, $t5, 200  
                                x"01696820",--00000001011010010110100000100000  -- 0x0000 03F4  --   add $t5, $t3, $s1  
                                x"33160064",--00110011000101100000000001100100  -- 0x0000 03F8  --   andi $s6,$t8,100                 --Salvador
                                x"11F80064",--00010001111110000000000001100100  -- 0x0000 03FC  --   beq $t7,$t8,100                  --Mustafa                  
                                x"012A9825",--00000001001010101001100000100101  -- 0x0000 0400  --   or $s3,$t1,$t2                   --Salvador
                                x"01F88824",--00000001111110001000100000100100  -- 0x0000 0404  --   and $s1,$t7,$t8    --Nand part 1 --Mustafa
                                x"00114827",--00000000000100010100100000100111  -- 0x0000 0408  --   nor $t1,$zero,$s1  --Nand part 2 --Mustafa
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000"
                                 );

begin
    --0x0000 0358 => 10000 (decimal); 
    Inst <= x"00000000" when Address = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" else
                   InstMem((to_integer(unsigned(Address)) - 1000) / 4);

end Behavioral;
