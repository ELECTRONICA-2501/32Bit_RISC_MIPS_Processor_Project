library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_Stage is
    Port ( clk, rst: in STD_LOGIC;                      
           NPC_in, Inst : in STD_LOGIC_VECTOR (31 downto 0); 
           NPC_out : out STD_LOGIC_VECTOR (31 downto 0);           
           wb_WriteRegister : in STD_LOGIC_VECTOR (4 downto 0);
           wb_WriteData : in STD_LOGIC_VECTOR (31 downto 0);           
           ReadData1, ReadData2, SignExtend1 : out STD_LOGIC_VECTOR (31 downto 0);                      
           RT, RD : out STD_LOGIC_VECTOR (4 downto 0);           
           wb_RegWrite_in : in STD_LOGIC;
           RegWrite_out, MemtoReg, MemWrite, MemRead, PCscr, RegDst, ALUSrc : out STD_LOGIC;                              
           ALUOp : out STD_LOGIC_VECTOR (1 downto 0)
           );
end ID_Stage;

architecture Structural of ID_Stage is

component SignExtend is
    port (
           Input : in STD_LOGIC_VECTOR(15 downto 0);
           Output : out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;

component ControlUnit is
    port(
           OPcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst,MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, PCscr : out STD_LOGIC;           
           ALUOp : out STD_LOGIC_VECTOR(1 downto 0)           
        );
end component;

component RegisterFile is
    port(
           RegWrite,clk, rst : in STD_LOGIC;                      
           ReadRegister1,ReadRegister2,WriteRegister : in STD_LOGIC_VECTOR (4 downto 0);           
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData1, ReadData2 : out STD_LOGIC_VECTOR (31 downto 0)                                            
        );
end component;

begin

Control: ControlUnit port map(Inst(31 downto 26), RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite_out, PCscr, ALUOp);
RegFile: RegisterFile port map(clk, rst, wb_RegWrite_in, Inst(25 downto 21), Inst(20 downto 16),
 wb_WriteRegister, wb_WriteData,ReadData1, ReadData2);
EXT: SignExtend port map(Inst(15 downto 0), SignExtend1);

RT <= Inst(20 downto 16);
RD <= Inst(15 downto 11);
NPC_out <= NPC_in;
end Structural;
 