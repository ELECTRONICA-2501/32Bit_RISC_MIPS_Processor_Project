library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( 
           clk, rst: in std_logic;           
           Address_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out : out STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is

type mem is array (0 to 0) of std_logic_vector(31 downto 0);

signal reg: mem;
signal temp:std_logic_vector(31 downto 0);

begin
    process(clk)
    begin
        
        if (rst = '1') then
            reg(0)<= x"000003E8";
        elsif rising_edge(clk) then
            if Address_in = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
                reg(0) <= x"000003E8";
            else
                reg(0) <= Address_in;
            end if;           
        end if;

end process;

Address_out<= reg(0);

end Behavioral;
