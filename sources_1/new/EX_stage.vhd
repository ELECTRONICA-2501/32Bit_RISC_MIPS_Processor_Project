library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EX_Stage is
    Port ( 
           RegWrite_in, MemtoReg_in, MemWrite_in, MemRead_in, Jump_in, RegDst, ALUSrc : in STD_LOGIC;
           RegWrite_out, MemtoReg_out, MemWrite_out, MemRead_out, Jump_out : out STD_LOGIC;                                                              
           ALUOp : in STD_LOGIC_VECTOR (1 downto 0);           
           NPC_in, ReadData1, ReadData2, SignExtend : in STD_LOGIC_VECTOR (31 downto 0);                                 
           RT, RD : in STD_LOGIC_VECTOR (4 downto 0);
           
           JumpAddr, ALUresult, WriteData : out STD_LOGIC_VECTOR (31 downto 0);                      
           wb_WriteRegister: out STD_LOGIC_VECTOR (4 downto 0));         
end EX_Stage;

architecture Structural of EX_Stage is

component ShiftLeft2 is 
    Port ( input : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Thirtytwo_bit_RCA is
    Port (     A,B : in STD_LOGIC_VECTOR (31 downto 0);
               Cin : in STD_LOGIC; 
               Sum : out STD_LOGIC_VECTOR (31 downto 0);
               Cout : out STD_LOGIC);
end component;

component MUX is
    port(
            a, b: in std_logic_vector(31 downto 0);
            sel: in std_logic;
            y: out std_logic_vector(31 downto 0)
        );
end component;

component ALU is
    Port ( in1, in2 : in STD_LOGIC_VECTOR (31 downto 0);            
           Cin: in std_logic;
           alu_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           Cout: out std_logic;
           alu_rslt : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALUControl is
    Port ( ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           FuncCode : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOperation : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component MUX_5bit is
    port(
            input1,input2: in std_logic_vector(4 downto 0);
            ctrl: in std_logic;
            output: out std_logic_vector(4 downto 0)
        );
end component;

signal signextend_out, MUX32bit_out: std_logic_vector(31 downto 0);
signal MUX5bit_out: std_logic_vector(4 downto 0);
signal ALUControl_out: std_logic_vector(3 downto 0);
signal add_c_out, alu_c_out: std_logic;

begin

Shifter: Shiftleft2 port map(SignExtend, signextend_out);

RCA: Thirtytwo_bit_RCA port map(NPC_in, signextend_out, '0', JumpAddr, add_c_out);

MUX32bit: MUX port map(ReadData2, SignExtend, ALUSrc, MUX32bit_out);

A_L_U: ALU port map(ReadData1, MUX32bit_out, '0', ALUControl_out, alu_c_out, ALUresult);

A_L_U_ctrl: ALUControl port map (ALUOp, SignExtend(5 downto 0), ALUControl_out);


wb_WriteRegister <= MUX5bit_out;
RegWrite_out <= RegWrite_in;
MemtoReg_out <= MemtoReg_in;
MemWrite_out <= MemWrite_in;
MemRead_out <= MemRead_in;
Jump_out <= Jump_in;
WriteData <= ReadData2;

end Structural;
