library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_EX_Stage is
end tb_EX_Stage;

architecture Structural of tb_EX_Stage is

signal tb_Jump_in, tb_MemRead_in, tb_MemWrite_in, tb_MemtoReg_in, tb_RegWrite_in: std_logic:= '0';
signal tb_ALUSrc, tb_RegDst: std_logic;
signal tb_ALUOp: std_logic_vector(1 downto 0);

signal tb_RT, tb_RD: std_logic_vector(4 downto 0);

signal tb_NPC_in, tb_ReadData1, tb_ReadData2, tb_SignExtend: std_logic_vector(31 downto 0);

signal tb_Jump_out, tb_MemRead_out, tb_MemWrite_out, tb_MemtoReg_out, tb_RegWrite_out: std_logic:= '0';
signal tb_wb_WriteRegister: std_logic_vector(4 downto 0);
signal tb_ALUresult, tb_JumpAddr, tb_WriteData: std_logic_vector( 31 downto 0);

begin

uut: entity work.EX_Stage(Structural)
    port map(
                RegWrite_in=>tb_RegWrite_in,
                RegWrite_out=>tb_RegWrite_out,
                
                MemtoReg_in=>tb_MemtoReg_in,
                MemtoReg_out=>tb_MemtoReg_out
                ,
                MemWrite_in=>tb_MemWrite_in,
                MemWrite_out=>tb_MemWrite_out,
                
                MemRead_in=>tb_MemRead_in,
                MemRead_out=>tb_MemRead_out,
                
                Jump_in=>tb_Jump_in,
                Jump_out=>tb_Jump_out,
                
                RegDst=>tb_RegDst,
                ALUSrc=>tb_ALUSrc,
                
                ALUOp=>tb_ALUOp,
                
                RT=>tb_RT,
                RD=>tb_RD,
                
                NPC_in=>tb_NPC_in,
                ReadData1=>tb_ReadData1,
                ReadData2=>tb_ReadData2,
                SignExtend=>tb_SignExtend,
                
                wb_WriteRegister=>tb_wb_WriteRegister,
                
                ALUresult=>tb_ALUresult,
                JumpAddr=>tb_JumpAddr,
                WriteData=>tb_WriteData
            );

stim_proc: process
begin
    wait for 400ns;
    
    tb_MemtoReg_in<='1';
    tb_RegDst<='1';
    tb_ALUSrc<= '0';
    tb_RegWrite_in<='1';
    tb_ReadData1<= x"00000017";
    tb_ReadData2<= x"00000019";
    tb_ALUOp<= "10";
    tb_SignExtend<=x"FFFF9022";
    tb_NPC_in<=x"000003EC";
    tb_RD<="10010";
    tb_RT<="10011";
    
    wait for 400ns;
    
end process;
    
end Structural;
