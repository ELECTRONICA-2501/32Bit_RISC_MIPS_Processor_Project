library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_ID_Register is
    Port ( 
           clk, rst: in std_logic;           
           NPC_in,Inst_in : in STD_LOGIC_VECTOR (31 downto 0);           
           NPC_out, Inst_out : out STD_LOGIC_VECTOR (31 downto 0));           
end IF_ID_Register;

architecture Behavioral of IF_ID_Register is
begin
    process(clk)
    begin
    
        if rst ='1' then
            NPC_out <= x"00000000";
            Inst_out<= x"00000000";
            
            elsif rising_edge(clk) then
                NPC_out <= NPC_in;
                Inst_out<= Inst_in;
        end if;
    end process;

end Behavioral;
