library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_MUX is
end Tb_MUX;

architecture Behavioral of Tb_MUX is

signal tb_a : STD_LOGIC_VECTOR(31 downto 0);
signal tb_b : STD_LOGIC_VECTOR(31 downto 0);
signal tb_sel : STD_LOGIC;
signal tb_y : STD_LOGIC_VECTOR(31 downto 0);


begin

uut: entity work.MUX(Behavioral)
    port map(
        a => tb_a,
        b => tb_b,
        sel => tb_sel,
        y => tb_y
    );
    
stim_proc : process 
begin
   tb_a <= x"ffffffff";
   tb_b <= x"00000000";
    
    tb_sel <= '0';
    wait for 100ns;
    
    tb_sel <= '1';
    wait for 100ns;
    
   --tb_a <= "11111";
   --tb_b <= "10101";
    
   --tb_sel <= '0';
   --wait for 100ns;
    
   --tb_sel <= '1';
   --wait for 100ns;

end process;

end Behavioral;
