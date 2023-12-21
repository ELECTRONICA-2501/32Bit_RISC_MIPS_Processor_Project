library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port ( clk, rst, RegWrite : in STD_LOGIC;                      
           ReadRegister1,ReadRegister2, WriteRegister : in STD_LOGIC_VECTOR (0 to 4);                      
           WriteData : in STD_LOGIC_VECTOR (0 to 31);                      
           ReadData1, ReadData2 : out STD_LOGIC_VECTOR (0 to 31)                                 
           );
end RegisterFile;

architecture Behavioral of RegisterFile is 

type reg is array (0 to 31) of std_logic_vector (31 downto 0);

signal reg_array: reg := ( x"00000000",--$zero
                           x"00000001",--$at
                           x"00000002",--$v0
                           x"00000003",--$v1
                           x"00000004",--$a0
                           x"00000005",--$a1
                           x"00000006",--$a2
                           x"00000007",--$a3
                           x"00000012",--$t0
                           x"00000049",--$t1
                           x"11111111",--$t2
                           x"00000011",--$t3
                           x"00000012",--$t4
                           x"00000000",--$t5
                           x"00000014",--$t6
                           x"00000015",--$t7
                           x"00000016",--$s0
                           x"00005000",--$s1
                           x"00000018",--$s2
                           x"00001000",--$s3
                           x"00000020",--$s4
                           x"00000021",--$s5
                           x"00000022",--$s6
                           x"00000023",--$s7
                           x"00000024",--$t8
                           x"00000025",--$t9
                           x"00000026",--$k0
                           x"00000027",--$k1
                           x"00000028",--$gp
                           x"00000029",--$sp
                           x"00000030",--$fp
                           x"00000031"--$ra
                         );
begin

process(CLK)
begin
    if (rst ='1') then
        reg_array(to_integer(unsigned(WriteRegister))) <= (others => '0');        
        elsif(rising_edge(CLK) and RegWrite = '1') then
            reg_array(to_integer(unsigned(WriteRegister))) <= WriteData;
    end if;

end process;

    ReadData1 <= reg_array(to_integer(unsigned(ReadRegister1)));
    ReadData2 <= reg_array(to_integer(unsigned(ReadRegister2)));
end Behavioral;
