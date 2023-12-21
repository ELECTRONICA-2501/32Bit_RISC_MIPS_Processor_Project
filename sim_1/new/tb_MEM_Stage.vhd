library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_MEM_Stage is
end tb_MEM_Stage;

architecture Structural of tb_MEM_Stage is 

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

signal tb_Jump, tb_MemRead, tb_MemWrite, tb_MemtoReg_in, tb_RegWrite_in: std_logic:='0';
signal tb_WriteRegister_in: std_logic_vector(4 downto 0);
signal tb_Address_in, tb_WriteData: std_logic_vector(31 downto 0);

signal tb_PCsrc,tb_MemtoReg_out, tb_RegWrite_out: std_logic;
signal tb_WriteRegister_out: std_logic_vector(4 downto 0);
signal tb_Address_out, tb_ReadData: std_logic_vector(31 downto 0);

begin 

uut: entity work.MEM_Stage(Structural)
        port map( 
                    clk => tb_clk,
                    rst => tb_reset,
                    Jump_in => tb_Jump,
                    MemRead=>tb_MemRead,
                    MemWrite=>tb_MemWrite,
                    WriteRegister_in=>tb_WriteRegister_in,
                    Address_in=>tb_Address_in,
                    WriteData=>tb_WriteData,
                    jump_out=>tb_PCsrc,
                    MemtoReg_in=>tb_MemtoReg_in,
                    RegWrite_in=>tb_RegWrite_in,
                    MemtoReg_out=>tb_MemtoReg_out,
                    RegWrite_out=>tb_RegWrite_out,
                    WriteRegister_out=>tb_WriteRegister_out,
                    Address_out=>tb_Address_out,
                    ReadData=>tb_ReadData
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
    tb_MemtoReg_in<='1';
    tb_RegWrite_in<='1';
    tb_WriteRegister_in<="01100";
    tb_Address_in<=x"FFFFFFFE";
    tb_WriteData<=x"00000019";
    
end process;


end Structural;
