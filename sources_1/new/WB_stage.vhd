library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WB_Stage is
    Port ( RegWrite_in, MemtoReg : in STD_LOGIC;           
           ReadData, ALUresult : in STD_LOGIC_VECTOR (31 downto 0);           
           WriteData : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0);
           RegWrite_out : out STD_LOGIC
           );
end WB_Stage;

architecture Structural of WB_Stage is

component MUX is
    
    Port ( a, b : in STD_LOGIC_VECTOR(31 downto 0);           
           sel : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;

begin
    MUX32bit: MUX port map(ReadData,ALUresult,MemtoReg,WriteData);
    RegWrite_out<=RegWrite_in;
    WriteRegister_out<= WriteRegister_in;


end Structural;
