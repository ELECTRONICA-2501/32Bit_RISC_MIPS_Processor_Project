library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ControlUnit is
end tb_ControlUnit;

architecture Behavioral of tb_ControlUnit is

signal tb_OPcode: std_logic_vector(5 downto 0);
signal tb_RegDst, tb_MemRead, tb_MemtoReg, tb_MemWrite, tb_ALUSrc, tb_RegWrite, tb_PCscr: std_logic;
signal tb_ALUOp: std_logic_vector(1 downto 0);

begin

uut: entity work.ControlUnit(Behavioral)
        port map(
                    OPcode => tb_OPcode,
                    RegDst=> tb_RegDst, 
                    MemRead=>tb_MemRead, 
                    MemtoReg=>tb_MemtoReg, 
                    MemWrite=> tb_MemWrite, 
                    ALUSrc=> tb_ALUSrc,
                    ALUOp => tb_ALUOp, 
                    RegWrite=> tb_RegWrite,
                    PCscr=> tb_PCscr
                );

stim_proc: process
begin

    tb_OPcode <= "000000"; --R-type
    wait for 20ns;
    
    tb_OPcode<= "100011"; --lw
    wait for 20ns;
    
    tb_OPcode<= "000101"; --bne
    wait for 20ns;
    
    tb_OPcode<= "000100"; --beq
    wait for 20ns;
    
    tb_OPcode<= "101011"; --sw
    wait for 20ns;
    
    tb_OPcode<= "000010"; --jump
    wait for 20ns;
    
    tb_OPcode<= "001100"; --andi
    wait for 20ns;
    
    tb_OPcode<= "000101"; --bne
    wait for 20ns;
    
    tb_OPcode<= "111111"; --random error
    wait for 20ns;
    
    end process;
    
end Behavioral;
