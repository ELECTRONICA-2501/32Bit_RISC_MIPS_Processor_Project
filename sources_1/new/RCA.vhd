library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Thirtytwo_bit_RCA is
    Port ( A,B : in STD_LOGIC_VECTOR (31 downto 0);             
           Cin : in STD_LOGIC; 
           Sum : out STD_LOGIC_VECTOR (31 downto 0);
           Cout : out STD_LOGIC
           );
end Thirtytwo_bit_RCA;

architecture Structural of Thirtytwo_bit_RCA is
Component Four_bit_RCA
    Port ( 
    A,B: in STD_LOGIC_VECTOR (3 downto 0);
    Cin: in STD_LOGIC;    
    Sum: out STD_LOGIC_VECTOR (3 downto 0); 
    Cout: out STD_LOGIC 
    );
End Component;

signal s1,s2,s3,s4,s5,s6,s7: STD_LOGIC; 
begin
    a1:Four_bit_RCA port map ( A(3 downto 0), B(3 downto 0), Cin, Sum(3 downto 0), s1); 
    a2:Four_bit_RCA port map ( A(7 downto 4), B(7 downto 4), s1, Sum(7 downto 4), s2); 
    a3:Four_bit_RCA port map ( A(11 downto 8), B(11 downto 8), s2, Sum(11 downto 8), s3); 
    a4:Four_bit_RCA port map ( A(15 downto 12), B(15 downto 12), s3, Sum(15 downto 12), s4); 
    a5:Four_bit_RCA port map ( A(19 downto 16), B(19 downto 16), s4, Sum(19 downto 16), s5); 
    a6:Four_bit_RCA port map ( A(23 downto 20), B(23 downto 20), s5, Sum(23 downto 20), s6); 
    a7:Four_bit_RCA port map ( A(27 downto 24), B(27 downto 24), s6, Sum(27 downto 24), s7); 
    a8:Four_bit_RCA port map ( A(31 downto 28), B(31 downto 28), s7, Sum(31 downto 28), Cout);

end Structural;
