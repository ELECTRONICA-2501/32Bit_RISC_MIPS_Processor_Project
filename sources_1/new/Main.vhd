library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
  Port ( clk,rst: in std_logic);
end Processor;

architecture Structural of Processor is

component IF_Stage is
    port(
           clk, rst, PCsrc : in STD_LOGIC;           
           JumpAddr : in STD_LOGIC_VECTOR (31 downto 0);                      
           NPC, Instruction_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component IF_ID_Register is
    port(
           clk, rst: in std_logic;           
           NPC_in, Inst_in : in STD_LOGIC_VECTOR (31 downto 0);           
           NPC_out,Inst_out : out STD_LOGIC_VECTOR (31 downto 0)           
        );
end component;

component ID_Stage is
    port(
           clk,rst : in STD_LOGIC;                     
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
end component;

component ID_EX_Register is
    port(
           clk,rst,RegWrite_in, MemtoReg_in, MemWrite_in, MemRead_in, Jump_in, RegDst_in, ALUSrc_in  : in STD_LOGIC;                                            
           RegWrite_out, MemtoReg_out, MemWrite_out, MemRead_out, Jump_out, RegDst_out,ALUSrc_out : out STD_LOGIC;                                                                      
                                 
           ALUOp_in : in STD_LOGIC_VECTOR (1 downto 0);                      
           ALUOp_out : out STD_LOGIC_VECTOR (1 downto 0);
                                 
           NPC_in, A1_in, A2_in, signext_in: in std_logic_vector(31 downto 0);                                 
           rt_in,rd_in: in std_logic_vector(4 downto 0);          
           
           NPC_out, A1_out, A2_out, signext_out: out std_logic_vector(31 downto 0);                                 
           rt_out, rd_out: out std_logic_vector(4 downto 0)        
        );        
end component;

component EX_Stage is
    port(
           RegWrite_in,MemtoReg_in, MemWrite_in, MemRead_in, Jump_in,  RegDst,ALUSrc : in STD_LOGIC;
           RegWrite_out, MemtoReg_out, MemWrite_out, MemRead_out, Jump_out : out STD_LOGIC;           
                                            
           ALUOp : in STD_LOGIC_VECTOR (1 downto 0);                                  
           NPC_in, ReadData1, ReadData2, SignExtend : in STD_LOGIC_VECTOR (31 downto 0);           
           RT, RD : in STD_LOGIC_VECTOR (4 downto 0);
                                 
           JumpAddr, ALUresult, WriteData : out STD_LOGIC_VECTOR (31 downto 0);                      
           wb_WriteRegister: out STD_LOGIC_VECTOR (4 downto 0)
        );
end component;        

component EX_MEM_Register is
    port(
           clk,rst : in STD_LOGIC;           
                      
           RegWrite_in,MemtoReg_in : in STD_LOGIC;
           RegWrite_out, MemtoReg_out : out STD_LOGIC;
                                 
           MemWrite_in, MemRead_in, Jump_in : in STD_LOGIC;                      
           MemWrite_out, MemRead_out, Jump_out : out STD_LOGIC;                       
                      
           ALUresult_in, WriteData_in, JumpAddr_in : in STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ALUresult_out, WriteData_out, JumpAddr_out : out STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0)           
        );
end component;

component MEM_Stage is
    port(
           clk, rst,Jump_in, MemRead, MemWrite, RegWrite_in, MemtoReg_in: in std_logic;
           Jump_out,RegWrite_out, MemtoReg_out : out STD_LOGIC;                     
           Address_in, WriteData, JumpAddr_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out, ReadData, JumpAddr_out : out STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_in: in std_logic_vector(4 downto 0);
           WriteRegister_out: out std_logic_vector(4 downto 0)           
        );
end component;

component MEM_WB_Register is
    port(
           clk, rst, RegWrite_in, MemtoReg_in : in STD_LOGIC;                     
           RegWrite_out, MemtoReg_out : out STD_LOGIC;           
                      
           ReadData_in, ALUresult_in : in STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ReadData_out, ALUresult_out : out STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0)
        );
end component;

component WB_Stage is
    port(
           RegWrite_in, MemtoReg : in STD_LOGIC;           
           ReadData, ALUresult : in STD_LOGIC_VECTOR (31 downto 0);           
           WriteData : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0);
           RegWrite_out : out STD_LOGIC
        );
end component;

signal MEM_Jump_out, mem_RegWrite_out, mem_MemtoReg_out: std_logic;
signal MEM_JumpAddr_out, mem_Address_out, mem_ReadData_out: std_logic_vector(31 downto 0);
signal mem_WriteRegister: std_logic_vector(4 downto 0);

signal IF_NPC, IF_Instr: std_logic_vector(31 downto 0);
    
signal wb_WriteRegister_out: std_logic_vector(4 downto 0);
signal wb_WriteData_out: std_logic_vector(31 downto 0);
signal wb_RegWrite_out: std_logic;
    
signal id_ReadData1_out, id_ReadData2_out, id_SignExtend_out: std_logic_vector(31 downto 0);
signal id_RT_out, id_RD_out: std_logic_vector(4 downto 0);
signal id_RegWrite_out,id_MemtoReg_out,id_MemWrite_out,id_MemRead_out,id_Jump_out,id_RegDst_out,id_ALUSrc_out: std_logic;
signal id_ALUOp_out: std_logic_vector(1 downto 0);
    
signal ex_RegWrite_out, ex_MemtoReg_out, ex_MemWrite_out, ex_MemRead_out, ex_Jump_out: std_logic;
signal ex_JumpAddr_out, ex_ALUresult_out, ex_WriteData_out: std_logic_vector(31 downto 0);
signal ex_WriteRegister: std_logic_vector(4 downto 0);

signal IF_ID_NPC, IF_ID_Instr: std_logic_vector(31 downto 0);
signal ID_NPC: std_logic_vector(31 downto 0);

signal ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Jump, ID_EX_RegDst, ID_EX_ALUSrc: std_logic;
signal ID_EX_ALUOp: std_logic_vector(1 downto 0);
signal ID_EX_NPC, ID_EX_A1, ID_EX_A2, ID_EX_Signext: std_logic_vector(31 downto 0);
signal ID_EX_RT, ID_EX_RD: STD_LOGIC_VECTOR(4 downto 0);

signal EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_Jump: std_logic;
signal EX_MEM_ALUresult, EX_MEM_WriteData, EX_MEM_JumpAddr: std_logic_vector(31 downto 0);
signal EX_MEM_WriteRegister: std_logic_vector(4 downto 0);

signal MEM_WB_RegWrite, MEM_WB_MemtoReg: std_logic;
signal MEM_WB_ReadData, MEM_WB_ALUresult: std_logic_vector(31 downto 0); 
signal MEM_WB_WriteRegister: std_logic_vector(4 downto 0);

begin

Stage_IF: IF_Stage port map(clk, rst, MEM_Jump_out,MEM_JumpAddr_out, IF_NPC, IF_Instr);

Reg1: IF_ID_Register port map(clk, rst, IF_NPC, IF_Instr, IF_ID_NPC, IF_ID_Instr);

Stage_ID: ID_Stage port map(clk, rst, IF_ID_NPC, IF_ID_Instr, ID_NPC,
                            wb_WriteRegister_out, wb_WriteData_out,
                            id_ReadData1_out,id_ReadData2_out,
                            id_SignExtend_out,id_RT_out,id_RD_out,
                            wb_RegWrite_out,id_RegWrite_out,
                            id_MemtoReg_out,id_MemWrite_out,
                            id_MemRead_out,id_Jump_out,
                            id_RegDst_out,id_ALUSrc_out,id_ALUOp_out);
                            
                                                        
Reg2: ID_EX_Register port map(clk, rst, id_RegWrite_out, id_MemtoReg_out, id_MemWrite_out,id_MemRead_out,id_Jump_out, id_RegDst_out,id_ALUSrc_out,
                              ID_EX_RegWrite,ID_EX_MemtoReg,ID_EX_MemWrite,ID_EX_MemRead,ID_EX_Jump,ID_EX_RegDst, ID_EX_ALUSrc,
                              ID_EX_ALUOp,id_ALUOp_out,
                              ID_NPC,id_ReadData1_out,id_ReadData2_out,id_SignExtend_out,id_RT_out,id_RD_out,
                              ID_EX_NPC,ID_EX_A1,ID_EX_A2,ID_EX_Signext, ID_EX_RT,ID_EX_RD);

Stage_EX: EX_Stage port map(ID_EX_RegWrite, ID_EX_MemtoReg,ID_EX_MemWrite,ID_EX_MemRead,ID_EX_Jump,ID_EX_RegDst,ID_EX_ALUSrc, 
                            ex_RegWrite_out, ex_MemtoReg_out, ex_MemWrite_out, ex_MemRead_out, ex_Jump_out, ID_EX_ALUOp,
                            ID_EX_NPC, ID_EX_A1, ID_EX_A2, ID_EX_Signext, ID_EX_RT, ID_EX_RD,
                            ex_JumpAddr_out, ex_ALUresult_out, ex_WriteData_out, ex_WriteRegister);

Reg3: EX_MEM_Register port map(clk, rst, ex_RegWrite_out, ex_MemtoReg_out, EX_MEM_RegWrite, EX_MEM_MemtoReg,
                              ex_MemWrite_out, ex_MemRead_out, ex_Jump_out, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_Jump,
                              ex_ALUresult_out, ex_WriteData_out,ex_JumpAddr_out, ex_WriteRegister, EX_MEM_ALUresult, 
                              EX_MEM_WriteData,EX_MEM_JumpAddr,EX_MEM_WriteRegister);

Stage_MEM: MEM_Stage port map(clk, rst, EX_MEM_Jump, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite,
                              EX_MEM_MemtoReg, MEM_Jump_out, mem_RegWrite_out, mem_MemtoReg_out,
                              EX_MEM_ALUresult, EX_MEM_WriteData, EX_MEM_JumpAddr, mem_Address_out,
                              mem_ReadData_out, MEM_JumpAddr_out, EX_MEM_WriteRegister, mem_WriteRegister);

Reg4: MEM_WB_Register port map(clk, rst, mem_RegWrite_out, mem_MemtoReg_out, MEM_WB_RegWrite, MEM_WB_MemtoReg,
                              mem_ReadData_out, mem_Address_out, mem_WriteRegister,
                              MEM_WB_ReadData, MEM_WB_ALUresult, MEM_WB_WriteRegister);

    Stage_WB: WB_Stage port map(MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_ReadData, MEM_WB_ALUresult, 
                            wb_WriteData_out, MEM_WB_WriteRegister, wb_WriteRegister_out, wb_RegWrite_out);

end Structural;
