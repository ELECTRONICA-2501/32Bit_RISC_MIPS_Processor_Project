library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Four_bit_RCA is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);            
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end Four_bit_RCA;

architecture Structural of Four_bit_RCA is

Component One_bit_RCA 
Port ( 
    A,B,CIN: in STD_LOGIC;          
    Sum,Cout: out STD_LOGIC    
);
End Component;

signal s1,s2,s3: STD_LOGIC; 
begin

    A1: One_bit_RCA port map ( A(0), B(0), Cin, Sum(0), s1);  
    A2: One_bit_RCA port map ( A(1), B(1), s1, Sum(1), s2); 
    A3: One_bit_RCA port map ( A(2), B(2), s2, Sum(2), s3); 
    A4: One_bit_RCA port map ( A(3), B(3), s3, Sum(3), Cout); 
    
end Structural;
