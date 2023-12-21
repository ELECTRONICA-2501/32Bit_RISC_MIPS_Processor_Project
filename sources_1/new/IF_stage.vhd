library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_Stage is
    Port ( clk,rst, PCsrc : in STD_LOGIC;           
           JumpAddr : in STD_LOGIC_VECTOR (31 downto 0);           
           NPC, Instruction_out : out STD_LOGIC_VECTOR (31 downto 0));            
end IF_Stage;

architecture Structural of IF_Stage is

component MUX is    
    port(
            a,b: in std_logic_vector(31 downto 0);            
            sel: in std_logic;
            y: out std_logic_vector(31 downto 0)
        );
end component;

component PC is 
    Port ( 
               clk,rst: in std_logic;               
               Address_in : in STD_LOGIC_VECTOR (31 downto 0);
               Address_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Thirtytwo_bit_RCA is
    Port (     A,B : in STD_LOGIC_VECTOR (31 downto 0);                
               Cin : in STD_LOGIC; 
               Sum : out STD_LOGIC_VECTOR (31 downto 0);
               Cout : out STD_LOGIC
               );
end component;

component InstructionMemory is
    Port ( Address : in STD_LOGIC_VECTOR (31 downto 0);
           Inst : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal PC_out, MUX_out, PC_plus_4: std_logic_vector(31 downto 0);
signal c_out: std_logic;

begin
    
    MUXunit: MUX port map(PC_plus_4,JumpAddr,PCsrc,MUX_out);
    PCunit: PC port map(clk,rst,MUX_out,PC_out);
    Addunit: Thirtytwo_bit_RCA port map(PC_out, x"00000004", '0',PC_plus_4,c_out);
    InstructionMemunit: InstructionMemory port map(PC_out, Instruction_out);
    NPC<=PC_plus_4;
end Structural;
