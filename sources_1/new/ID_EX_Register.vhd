library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX_Register is
    Port (
           clk, rst : in STD_LOGIC;          
          
           RegWrite_in, MemtoReg_in, MemWrite_in, MemRead_in, Jump_in : in STD_LOGIC;            
           RegWrite_out, MemtoReg_out, MemWrite_out, MemRead_out, Jump_out : out STD_LOGIC;                                 
                      
           RegDst_in, ALUSrc_in : in STD_LOGIC;
           ALUOp_in : in STD_LOGIC_VECTOR (1 downto 0);           
           RegDst_out, ALUSrc_out : out STD_LOGIC;
           ALUOp_out : out STD_LOGIC_VECTOR (1 downto 0);
           
           NPC_in, A1_in, A2_in, signext_in: in std_logic_vector(31 downto 0);           
           rt_in, rd_in: in std_logic_vector(4 downto 0);           
           
           NPC_out, A1_out, A2_out, signext_out: out std_logic_vector(31 downto 0);                                 
           rt_out, rd_out: out std_logic_vector(4 downto 0)          
           );
           
end ID_EX_Register;

architecture Behavioral of ID_EX_Register is
begin
    process(clk)
    begin
    
        if rst = '1' then
            
            MemWrite_out<='0';
            RegWrite_out <= '0';
            MemtoReg_out <= '0';        
            MemRead_out<='0';
            Jump_out<='0';        
            RegDst_out<='0';
            ALUOp_out<= "00";
            ALUSrc_out<= '0';            
            NPC_out<= x"00000000";
            A1_out<= x"00000000";
            A2_out<= x"00000000";
            signext_out<= x"00000000";
            rt_out<= "00000";
            rd_out<="00000";
            
            elsif rising_edge(clk) then
                RegWrite_out <= RegWrite_in;
                MemtoReg_out <= MemtoReg_in;                
                MemWrite_out<=MemWrite_in;
                MemRead_out<=MemRead_in;
                Jump_out<=Jump_in;                
                RegDst_out<=RegDst_in;
                ALUOp_out<= ALUOp_in;
                ALUSrc_out<= ALUSrc_in;                
                NPC_out<= NPC_in;
                A1_out<= A1_in;
                A2_out<= A2_in;
                signext_out<= signext_in;
                rt_out<= rt_in;
                rd_out<=rd_in;
    end if;          
end process;


end Behavioral;
