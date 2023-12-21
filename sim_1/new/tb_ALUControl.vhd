library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALUControl is
end tb_ALUControl;

architecture Behavioral of tb_ALUControl is

signal tb_ALUOp: std_logic_vector(1 downto 0);
signal tb_FunctionCode: std_logic_vector(5 downto 0);
signal tb_ALUOperation: std_logic_vector(3 downto 0);

begin

uut: entity work.ALUControl(Behavioral)
        port map(
                    ALUOp => tb_ALUOp,
                    FuncCode => tb_FunctionCode,
                    ALUOperation => tb_ALUOperation
                );

stim_Proc: Process
begin

tb_ALUOp <= "10";
tb_FunctionCode <= "100000";  --add
wait for 30ns;


tb_ALUOp <= "01";
tb_FunctionCode <= "XXXXXX";  --beq
wait for 30ns;


tb_ALUOp <= "01";
tb_FunctionCode <= "XXXXXX";  --bne
wait for 30ns;


tb_ALUOp <= "10";
tb_FunctionCode <= "100000";  --add
wait for 30ns;

    
tb_ALUOp <= "10";
tb_FunctionCode <= "100010";  --sub
wait for 30ns;

    
tb_ALUOp <= "10";
tb_FunctionCode <= "100100";  -- and 
wait for 30ns;

    
tb_ALUOp <= "10";
tb_FunctionCode <= "100101"; -- or
wait for 30ns;

    
tb_ALUOp <= "10";
tb_FunctionCode <= "100111"; --nor 
wait for 30ns;   


tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";  --addi
wait for 30ns;


tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";  --lw
wait for 30ns;


tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";  --sw
wait for 30ns;


end process;


end Behavioral;
