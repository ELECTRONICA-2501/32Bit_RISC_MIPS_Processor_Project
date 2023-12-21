library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
end tb_ALU;

architecture Behavioral of tb_ALU is
    signal tb_a1, tb_a2: std_logic_vector(31 downto 0); 
    signal tb_alu_ctrl: std_logic_vector(3 downto 0); 
    signal tb_Cin, tb_Cout: std_logic;    
    signal tb_alu_rslt: std_logic_vector (31 downto 0); 

begin

uut: entity work.ALU(Behavioral) 
    port map(
        in1 => tb_a1,
        in2 => tb_a2,
        alu_ctrl => tb_alu_ctrl,
        Cin => tb_Cin,
        Cout => tb_Cout,
        alu_rslt => tb_alu_rslt
    );
    
 stim_proc: process
 begin
 
    tb_a1 <= x"FFFF0000";
    tb_a2 <= x"0000FFFF";
    tb_Cin <= '0';
    
    tb_alu_ctrl <= "0000"; --AND 
    wait for 10ns;
    
    tb_alu_ctrl <= "0001"; --OR 
    wait for 10ns;
 
    tb_alu_ctrl <= "0010"; --add, cout=0
    wait for 10ns;
    
    tb_Cin <= '1';
    tb_alu_ctrl <= "0010"; --add, cout=1
    wait for 10ns;
    
    tb_alu_ctrl <= "0110"; --sub 
    wait for 10ns;
    
    tb_alu_ctrl <= "1100"; --NOR 
    wait for 10ns;
    
    tb_alu_ctrl <= "1111"; --random error
    wait for 10ns;
    
 
 end process;
 
end Behavioral;
