library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB_Register is
    Port ( clk, rst, RegWrite_in, MemtoReg_in  : in STD_LOGIC;           
           RegWrite_out, MemtoReg_out : out STD_LOGIC;                     
           ReadData_in, ALUresult_in : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ReadData_out, ALUresult_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0)
           );
end MEM_WB_Register;

architecture Behavioral of MEM_WB_Register is
begin
    process(clk)
    begin
    
        if rst = '1' then
            RegWrite_out <= '0';
            MemtoReg_out <= '0';
            
            elsif rising_edge(clk) then
                ReadData_out<= ReadData_in;
                ALUresult_out<=ALUresult_in;
                WriteRegister_out<=WriteRegister_in;
        end if;
end process;

end Behavioral;
