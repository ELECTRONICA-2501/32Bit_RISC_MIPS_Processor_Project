library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_RegisterFile is
end tb_RegisterFile;

architecture Behavioral of tb_RegisterFile is

signal tb_ReadRegister1, tb_ReadRegister2, tb_WriteRegister: std_logic_vector(4 downto 0);
signal  tb_WriteData, tb_ReadData1, tb_ReadData2: std_logic_vector(31 downto 0);
signal tb_RegWrite: std_logic;

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

begin

uut: entity work.RegisterFile(Behavioral)
        Port map ( 
                ReadRegister1 => tb_ReadRegister1,
                ReadRegister2 => tb_ReadRegister2,
                WriteRegister => tb_WriteRegister,
                WriteData => tb_WriteData,
                ReadData1 => tb_ReadData1,
                ReadData2 => tb_ReadData2,
                RegWrite => tb_RegWrite,
                CLK => tb_clk,
                rst => tb_reset        
                 );


clk_process: process
begin

tb_clk <= '0';
wait for clk_period/2;

tb_clk<= '1';
wait for clk_period/2;

end process;


stim_proce: process
begin

tb_RegWrite<='0';
tb_ReadRegister1<="10000";
wait for 200ns;

tb_RegWrite<='1';
tb_WriteRegister<="10000"; 
tb_WriteData <= x"ABCDEF12";
wait for 200ns;
 
tb_RegWrite<='0';
tb_ReadRegister1<="10000";
wait for 200ns;

tb_reset<= '1';
wait for 200ns;

tb_RegWrite<='0';
tb_ReadRegister1<="10000";
wait for 200ns;
 
end process;

end Behavioral;
