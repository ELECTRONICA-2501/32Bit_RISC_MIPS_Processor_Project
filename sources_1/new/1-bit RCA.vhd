library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity One_bit_RCA is
    Port ( A, B, CIN : in STD_LOGIC;              
           Sum, COUT : out STD_LOGIC); 
end One_bit_RCA;

architecture Behavioral of One_bit_RCA is
begin

Sum <= A xor B xor Cin; 
Cout <= (A and B) or (A and Cin) or (B and Cin); 

end Behavioral;
