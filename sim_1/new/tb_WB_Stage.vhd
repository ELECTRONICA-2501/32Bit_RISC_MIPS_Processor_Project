library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_WB_Stage is
end tb_WB_Stage;

architecture Structural of tb_WB_Stage is

signal tb_MemtoReg, tb_RegWrite_in: std_logic;
signal tb_ReadData, tb_ALUresult: std_logic_vector(31 downto 0);
signal tb_WriteRegister_in: std_logic_vector(4 downto 0);

signal tb_WriteData: std_logic_vector(31 downto 0);
signal tb_RegWrite_out: std_logic;
signal tb_WriteRegister_out: std_logic_vector(4 downto 0);

begin

uut: entity work.WB_Stage(Structural)
    port map(
            MemtoReg=>tb_MemtoReg,
            RegWrite_in=>tb_RegWrite_in,
            ReadData=>tb_ReadData,
            ALUresult=>tb_ALUresult,
            WriteRegister_in=>tb_WriteRegister_in,
            WriteData=>tb_WriteData,
            RegWrite_out=>tb_RegWrite_out,
            WriteRegister_out=>tb_WriteRegister_out
            );

stim_proc: process
begin
    wait for 400ns;
    tb_MemtoReg<='1';
    tb_RegWrite_in<='1';
    tb_ReadData<=x"00000000";
    tb_ALUresult<=x"FFFFFFFE";
    tb_WriteRegister_in<="01100";

end process;

end Structural;
