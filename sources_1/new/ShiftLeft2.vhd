library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLeft2 is
    Port ( input : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end ShiftLeft2;

architecture Behavioral of ShiftLeft2 is
begin

output <= input(29 downto 0) & "00";

end Behavioral;
 