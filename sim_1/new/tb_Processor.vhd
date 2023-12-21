library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Processor is
end TB_Processor;

architecture Structural of TB_Processor is

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

begin

uut: entity work.Processor(Structural)
    port map(
                clk => tb_clk,
                rst => tb_reset
            );

clk_process: process
begin

tb_clk <= '0';
wait for clk_period/4;

tb_clk<= '1';
wait for clk_period/4;

end process;


stim_proc: process
begin

wait for 200ns;

end process;


end Structural;
