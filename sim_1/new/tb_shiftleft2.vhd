library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_shiftleft2 is
end tb_shiftleft2;

architecture Behavioral of tb_shiftleft2 is
signal tb_input, tb_output: std_logic_vector(31 downto 0);
begin

uut: entity work.ShiftLeft2(Behavioral) 
       port map(
        input => tb_input,
        output => tb_output
       );
       
stim_proc: process

    begin
    
        tb_input <= x"FFFFFFFF";    
        wait for 10ns;    
        tb_input <= x"12345678";    
        wait for 10ns;     
        end process;
    
end Behavioral;
