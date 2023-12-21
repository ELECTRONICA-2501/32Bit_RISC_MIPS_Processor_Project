library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_Stage is 
    Port ( 
           clk, rst, Jump_in, MemRead, MemWrite, RegWrite_in, MemtoReg_in: in std_logic;
           Jump_out,RegWrite_out,MemtoReg_out : out STD_LOGIC;                      
           Address_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in: in std_logic_vector(4 downto 0);
           WriteRegister_out: out std_logic_vector(4 downto 0);
           ReadData : out STD_LOGIC_VECTOR (31 downto 0);
           JumpAddr_in : in STD_LOGIC_VECTOR(31 downto 0);
           JumpAddr_out : out STD_LOGIC_VECTOR(31 downto 0)
           );
end MEM_Stage;

architecture Structural of MEM_Stage is

component DataMemory is
    port(
           clk,rst : in std_logic;
           Address, WriteData : in STD_LOGIC_VECTOR (31 downto 0);               
           MemRead, MemWrite: in std_logic;                              
           ReadData : out STD_LOGIC_VECTOR (31 downto 0) 
            );
end component;


begin

DataMem: DataMemory port map(clk, rst, Address_in, WriteData, MemRead, MemWrite,ReadData);

    WriteRegister_out<=WriteRegister_in;
    Address_out<= Address_in;
    Jump_out <= Jump_in;
    JumpAddr_out<=JumpAddr_in;
    RegWrite_out<=RegWrite_in;
    MemtoReg_out<=MemtoReg_in;
    
end Structural;
