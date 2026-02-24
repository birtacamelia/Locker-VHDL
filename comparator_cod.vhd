----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 06:27:01 PM
-- Design Name: 
-- Module Name: comparator_cod - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator_cod is
Port (    en :in std_logic;
reg1,reg2,reg3,reg4,reg5,reg6: in std_logic_vector(3 downto 0);
       deblocat :out std_logic);
end comparator_cod;

architecture Behavioral of comparator_cod is

begin
   process(reg1,reg2,reg3,reg4,reg5,reg6,en)
     begin
     if en='1' then
       if(reg1=reg4) and (reg2=reg5) and (reg3=reg6)then
         deblocat<='1';
       else
      deblocat<='0';
      end if;
     else
     deblocat<='0';
      end if;
     end process;
end Behavioral;
