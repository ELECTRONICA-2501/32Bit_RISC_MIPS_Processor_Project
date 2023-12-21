library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_InstructionMemory is
end tb_InstructionMemory;

architecture Behavioral of tb_InstructionMemory is

signal tb_Address : std_logic_vector(31 downto 0) := x"000003E4";
signal tb_Instruction: std_logic_vector(31 downto 0);

begin

uut: entity work.InstructionMemory
    port map(
                Address => tb_Address,
                Inst => tb_Instruction
            );

stim_proc: process

begin

    for i in 0 to 15 loop    
        tb_Address <= x"000003E8" or std_logic_vector(to_unsigned(i*4,32)); 
        wait for 30ns;
    end loop;
    wait;

end process;


end Behavioral;

