----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 10:28:42 AM
-- Design Name: 
-- Module Name: comparator_cifre - Behavioral
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

entity comparator_cifre is
 Port( cif1,cif2,cif3: in std_logic_vector (3 downto 0);
       diferit: out std_logic); 
end comparator_cifre;

architecture Behavioral of comparator_cifre is
begin
   process(cif1,cif2,cif3)
     begin
    if ((cif1=cif3) or (cif2=cif3) or (cif1=cif2)) then
     diferit<='0';
    else
    diferit<='1';
     end if;
  end process;
end Behavioral;
