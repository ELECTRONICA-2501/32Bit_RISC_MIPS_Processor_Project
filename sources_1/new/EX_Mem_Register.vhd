library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_MEM_Register is
    Port ( 
           clk, rst, RegWrite_in, MemtoReg_in, MemWrite_in, MemRead_in, Jump_in : in STD_LOGIC ;                                           
           RegWrite_out,MemtoReg_out, MemWrite_out, MemRead_out, Jump_out : out STD_LOGIC;                      
           ALUresult_in, WriteData_in, JumpAddr_in : in STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ALUresult_out, WriteData_out, JumpAddr_out : out STD_LOGIC_VECTOR (31 downto 0);           
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0)                      
           );
end EX_MEM_Register;

architecture Behavioral of EX_MEM_Register is
begin
    process(clk)
    begin
    
        if rst = '1' then
            
            RegWrite_out <= '0';
            MemWrite_out<='0';
            MemRead_out<='0';
            MemtoReg_out <= '0';               
            Jump_out<='0';
            
            WriteData_out<= x"00000000";
            WriteRegister_out<= "00000";
            JumpAddr_out<=x"00000000";
            ALUresult_out<= x"00000000";
                    
        elsif rising_edge(clk) then
                RegWrite_out <= RegWrite_in;
                MemtoReg_out <= MemtoReg_in;            
                MemWrite_out<=MemWrite_in;
                MemRead_out<=MemRead_in;
                Jump_out<=Jump_in;            
                ALUresult_out<= ALUresult_in;
                WriteData_out<= WriteData_in;
                WriteRegister_out<= WriteRegister_in;
                JumpAddr_out<=JumpAddr_in;
        end if;
    end process;
end Behavioral;
