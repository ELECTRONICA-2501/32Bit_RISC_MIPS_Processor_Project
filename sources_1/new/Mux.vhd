library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port (  a : in STD_LOGIC_VECTOR(31 downto 0);
            b: in STD_LOGIC_VECTOR(31 downto 0);
            sel : in STD_LOGIC;
            y : out STD_LOGIC_VECTOR(31 downto 0));
end MUX;

architecture Behavioral of MUX is
begin

    y <= a when sel = '0' else b;
    
end Behavioral;
