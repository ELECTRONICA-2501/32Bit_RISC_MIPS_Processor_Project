library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ID_Stage is
end tb_ID_Stage;

architecture Structural of tb_ID_Stage is

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

signal tb_id_NPC_in, tb_id_Instruction, tb_wb_WriteData: std_logic_vector(31 downto 0); 
signal tb_wb_RegWrite_in: std_logic;
signal tb_wb_WriteRegister: std_logic_vector(4 downto 0);

signal tb_id_NPC_out, tb_id_ReadData1, tb_id_ReadData2, tb_id_SignExtend: std_logic_vector(31 downto 0);
signal tb_id_RegDst, tb_id_ALUSrc, tb_id_Jump, tb_id_MemRead, tb_id_MemWrite, tb_id_MemtoReg, tb_id_RegWrite_out: std_logic;
signal tb_id_ALUOp: std_logic_vector(1 downto 0);
signal tb_id_RD, tb_id_RT: std_logic_vector(4 downto 0);


begin

uut: entity work.ID_Stage(Structural)
    port map(
                clk => tb_clk,
                rst => tb_reset,
                NPC_in=> tb_id_NPC_in, 
                Inst=> tb_id_Instruction, 
                wb_WriteData=> tb_wb_WriteData,                
                wb_RegWrite_in=> tb_wb_RegWrite_in,
                wb_WriteRegister=> tb_wb_WriteRegister,
                NPC_out=> tb_id_NPC_out, 
                ReadData1=> tb_id_ReadData1, 
                ReadData2=> tb_id_ReadData2, 
                SignExtend1=> tb_id_SignExtend,                
                ALUSrc=> tb_id_ALUSrc, 
                PCscr=> tb_id_Jump, 
                MemRead=> tb_id_MemRead, 
                MemWrite=> tb_id_MemWrite, 
                MemtoReg=> tb_id_MemtoReg, 
                RegWrite_out=>tb_id_RegWrite_out,
                RegDst=>tb_id_RegDst,                
                ALUOp=> tb_id_ALUOp,                
                RD=> tb_id_RD, 
                RT=> tb_id_RT
            );


clk_process: process
    begin
    
        tb_clk <= '0';
        wait for clk_period/2;
        
        tb_clk<= '1';
        wait for clk_period/2;
        
        end process;
    
stim_proc: process
begin
    wait for 400ns;
    
    tb_id_NPC_in <= x"000003EC";
    tb_id_Instruction<= x"02339022";
    tb_wb_WriteData<= x"00000000";
    tb_wb_RegWrite_in<= '0';
    tb_wb_WriteRegister<= "00000";
    
    wait for 400ns;
    
    end process;


end Structural;
