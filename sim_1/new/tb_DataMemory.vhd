library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_DataMemory is
end tb_DataMemory;


architecture Behavioral of tb_DataMemory is

signal tb_Address, tb_WriteData, tb_ReadData : std_logic_vector(31 downto 0);

signal tb_MemWrite, tb_MemRead: std_logic;

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;


begin

uut: entity work.DataMemory(Behavioral)
        port map (
                    Address => tb_Address,
                    WriteData => tb_WriteData,
                    ReadData => tb_ReadData,
                    MemWrite => tb_MemWrite,
                    MemRead => tb_MemRead,
                    clk => tb_clk,
                    rst => tb_reset
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

tb_Address <= x"10000000"; -- modifiy address 0x1000 0000
tb_WriteData <= x"12345678";

tb_MemWrite <= '0';
tb_MemRead <= '0';
wait for 400ns;

tb_MemWrite <= '0';
tb_MemRead <= '1';
wait for 400ns;

tb_MemWrite <= '1';
tb_MemRead <= '0';
wait for 400ns;

tb_MemWrite <= '0';
tb_MemRead <= '1';
wait for 400ns;

tb_Address <= x"10000004"; -- modify address 0x1000 0004
tb_WriteData <= x"12345678";

tb_MemWrite <= '0';
tb_MemRead <= '0';
wait for 400ns;

tb_MemWrite <= '0';
tb_MemRead <= '1';
wait for 400ns;

tb_MemWrite <= '1';
tb_MemRead <= '0';
wait for 400ns;

tb_MemWrite <= '0';
tb_MemRead <= '1';
wait for 400ns;

tb_reset<= '1';
wait for 400ns;

tb_MemRead <= '1';
tb_Address<=x"10000000";
wait for 400ns;
end process;

end Behavioral;
