library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    Port ( 
           clk, rst: in  STD_LOGIC;           
           Address, WriteData  : in STD_LOGIC_VECTOR (31 downto 0);
           MemRead, MemWrite : in std_logic;
           ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
type mem is array (0 to 20) of std_logic_vector(31 downto 0);
signal DataMem: mem := ( x"00000001", 
                         x"00000002",
                         x"00000003",
                         x"00000004",
                         x"00000005",
                         x"00000006",
                         x"00000007",
                         x"00000008",
                         x"00000009",
                         x"00000010",
                         x"00000011",
                         x"00000012",
                         x"00000013",
                         x"00000014",
                         x"00000015",
                         x"00000016",
                         x"00000017",
                         x"00000018",
                         x"00000019",
                         x"00000020",
                         x"00000021"
                       );
begin
    process(clk)   
    begin
      if (rst = '1') then
        DataMem<= (others=>(others=>'0'));
        -- 0x1000 0000 is 268435456 in decimal
        elsif (rising_edge(clk) and MemWrite = '1' ) then
            if Address < x"10000000" then
                DataMem(0) <= WriteData;
            else
                DataMem(to_integer(unsigned(Address))- 268435456 / 4) <= WriteData;
            end if;                     
      end if;
      
      if (Address = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" or Address < x"10000000") then
        ReadData<=x"00000000";
        elsif (MemRead='1') then
            ReadData <= DataMem((to_integer(unsigned(Address)) - 268435456) / 4);
      end if;    
    end process;
end Behavioral;
