----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 08:11:23 PM
-- Design Name: 
-- Module Name: numarator_up_down - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity numarator_up_down is
  Port( clk,res, btn_up,btn_down,en: in std_logic;
       count: out std_logic_vector(3 downto 0));
end numarator_up_down;

architecture Behavioral of numarator_up_down is
  component MPG is
     Port ( btn : in STD_LOGIC;
            clk : in STD_LOGIC;
            en : out STD_LOGIC);
  end component;
   signal tmp: std_logic_vector(3 downto 0):="0000";
   signal up,down: std_logic;
begin
   C1: MPG port map (btn_up,clk,up);
   C2: MPG port map (btn_down,clk,down);
   --
  process(res,clk)
    begin
       if res='1' then
         tmp<="0000";
       elsif rising_edge(clk) then
       if en='1' then
          if up='1' and tmp < "1111" then 
             tmp<=tmp+1;
          elsif down='1' and tmp > "0000" then
               tmp<=tmp-1;
            end if;
            end if;
            end if;
       end process;
     count <=tmp;
end Behavioral;
