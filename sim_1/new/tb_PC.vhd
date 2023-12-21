library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PC is
end tb_PC;

architecture Behavioral of tb_PC is
signal tb_Address_in, tb_Address_out: std_logic_vector(31 downto 0);

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

begin

uut: entity work.PC(Behavioral)
        port map(
                    clk=>tb_clk,
                    rst => tb_reset,
                    Address_in =>tb_Address_in,
                    Address_out=>tb_Address_out
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
    
    tb_Address_in<=x"12345678";
    wait for 400ns;

    tb_reset<= '1';

end process;

end Behavioral;
