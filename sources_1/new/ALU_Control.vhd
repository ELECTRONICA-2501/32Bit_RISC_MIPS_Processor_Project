library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port ( ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           FuncCode : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOperation : out STD_LOGIC_VECTOR (3 downto 0));
end ALUControl;

architecture Behavioral of ALUControl is
begin

    ALUOperation(0) <= (FuncCode(0) or FuncCode(3)) and ALUOp(1) ;
    ALUOperation(1) <= (not ALUOp(1)) or (not FuncCode(2));
    ALUOperation(2) <= (ALUOp(1) and FuncCode(1)) or ALUOp(0);
    ALUOperation(3) <= '0';

end Behavioral;
