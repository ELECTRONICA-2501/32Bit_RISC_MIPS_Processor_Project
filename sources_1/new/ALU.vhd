library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( in1, in2: in STD_LOGIC_VECTOR (31 downto 0);
           Cin: in std_logic;
           alu_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           Cout: out std_logic;
           alu_rslt : out STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

signal temp_rslt: std_logic_vector(31 downto 0);
signal temp_add_rslt: std_logic_vector(31 downto 0);
signal temp_cout: std_logic;

Component Thirtytwo_bit_RCA
 Port ( 
       A, B : in STD_LOGIC_VECTOR (31 downto 0);          
       Cin : in STD_LOGIC; 
       Sum : out STD_LOGIC_VECTOR (31 downto 0);
       Cout : out STD_LOGIC
       );
End Component;

begin
RCA: Thirtytwo_bit_RCA port map ( in1, in2, Cin, temp_add_rslt, temp_cout);
    process(in1, in2, alu_ctrl)
    begin
        case alu_ctrl is            
            when "0000" => -- AND
                temp_rslt <= in1 and in2;
            when "0110" => -- SUB
                temp_rslt <= std_logic_vector(unsigned(in1) - unsigned(in2));                
            when "0001" => -- OR
                temp_rslt <= in1 or in2;                
            when "0010" => -- ADD                    
                temp_rslt <= temp_add_rslt;                                            
            when "1100" => -- NOR
                temp_rslt <= in1 nor in2;                                          
            when others => null;
                temp_rslt <= x"00000000";    
           end case;
    end process;

alu_rslt <= temp_rslt;
Cout <= temp_cout;

end Behavioral;
