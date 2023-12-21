library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( OPcode : in STD_LOGIC_VECTOR (5 downto 0);           
           ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
           RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, PCscr : out STD_LOGIC
           );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(OPcode)
    begin    
        case OPcode is                
               when "000000" =>  -- r-type (or)(add)(nor)(and) 
                    RegDst <= '1';
                    MemRead <= '0';
                    MemtoReg <= '1';
                    ALUOp <= "10";
                    MemWrite <= '0';
                    ALUSrc <= '0';
                    RegWrite <='1';
                    PCscr <= '0';
                                
                when "000101" =>   --bne
                    RegDst <= '1';
                    MemRead <= '0';
                    MemtoReg <= '1';
                    ALUOp <= "01";
                    MemWrite <= '0';
                    ALUSrc <= '0';
                    RegWrite <='1';
                    PCscr <= '0';                                  
                     
                when "100011" =>  --lw    
                    RegDst <= '0';
                    MemRead <= '1';
                    MemtoReg <= '1';
                    ALUOp <= "00";
                    MemWrite <= '0';
                    ALUSrc <= '1';
                    RegWrite <='1';
                    PCscr <= '0';
                           
                when "101011" =>  --sw   
                    RegDst <= 'X';
                    MemRead <= '0';
                    MemtoReg <= 'X';
                    ALUOp <= "00";
                    MemWrite <= '1';
                    ALUSrc <= '1';
                    RegWrite <= '0';
                    PCscr <= '0';
                                    
                when "000010" =>  --jump   
                    RegDst <= 'X';
                    MemRead <= '0';
                    MemtoReg <= 'X';
                    ALUOp <= "00";
                    MemWrite <= '0';
                    ALUSrc <= '0';
                    RegWrite <='0';
                    PCscr <= '1';                                                                                            
                
                 when "000100" =>  --beq 
                    RegDst <= '1';
                    MemRead<= '0';
                    MemtoReg<= '1';
                    ALUOp<= "01";
                    MemWrite<= '0';
                    ALUSrc<= '0';
                    RegWrite<='1';
                    PCscr <= '0'; 
                    
                 when "001101" =>  --ori 
                    RegDst <= '1';
                    MemRead<= '0';
                    MemtoReg<= '0';
                    ALUOp<= "10";
                    MemWrite<= '0';
                    ALUSrc<= '1';
                    RegWrite<='1';
                    PCscr <= '0';      
                    
                 when "001100" =>  --andi 
                    RegDst <= '1';
                    MemRead<= '0';
                    MemtoReg<= '0';
                    ALUOp<= "10";
                    MemWrite<= '0';
                    ALUSrc<= '1';
                    RegWrite<='1';
                    PCscr <= '0';                                    
                    
               when others=> null;
                    RegDst <= '0';
                    MemRead<= '0';
                    MemtoReg<= '0';
                    ALUOp<= "00";
                    MemWrite<= '0';
                    ALUSrc<= '0';
                    RegWrite<='0';
                    PCscr <= '0';            
        end case;           
    end process;    
end Behavioral;
