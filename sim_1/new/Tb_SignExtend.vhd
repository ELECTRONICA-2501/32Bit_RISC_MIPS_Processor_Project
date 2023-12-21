library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_SignExtend is
end Tb_SignExtend;

architecture Behavioral of Tb_SignExtend is

signal tb_Input: std_logic_vector(15 downto 0) := (others => '0');
signal tb_Output: std_logic_vector(31 downto 0);

begin

uut: entity work.SignExtend(Behavioral)
    port map(
           Input => tb_Input,
           Output => tb_Output
    );

stim_process: process
begin
    tb_Input <= x"7fff";
    wait for 100ns;
    
    tb_Input <= x"8000";
    wait for 100ns;
end process;

end Behavioral;
