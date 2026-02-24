----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 05:52:32 PM
-- Design Name: 
-- Module Name: BCD_decod - Behavioral
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

entity BCD_decod is
Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
       Seven_Segment : out STD_LOGIC_VECTOR (0 to 6);
       Anod_in : in STD_LOGIC_VECTOR (3 DOWNTO 0);
       Anod_out : out STD_LOGIC_VECTOR (3 downto 0));
end BCD_decod;

architecture Behavioral of BCD_decod is


begin
process(BCDin)
begin
  if Anod_in = "1111" then
    Seven_Segment <= "1111111"; -- toate stinse
  else
case BCDin is
when "0000" =>
Seven_Segment <= "0000001"; ---0
when "0001" =>
Seven_Segment <= "1001111"; ---1
when "0010" =>
Seven_Segment <= "0010010"; ---2
when "0011" =>
Seven_Segment <= "0000110"; ---3
when "0100" =>
Seven_Segment <= "1001100"; ---4
when "0101" =>
Seven_Segment <= "0100100"; ---5
when "0110" =>
Seven_Segment <= "0100000"; ---6
when "0111" =>
Seven_Segment <= "0001111"; ---7
when "1000" =>
Seven_Segment <= "0000000"; ---8
when "1001" =>
Seven_Segment <= "0000100"; ---9
when "1010" =>
Seven_Segment <= "0001000"; ---10
when "1011" =>
Seven_Segment <= "1100000"; ---11
when "1100" =>
Seven_Segment <= "0110001"; ---12
when "1101" =>
Seven_Segment <= "1000010"; ---13
when "1110" =>
Seven_Segment <= "0110000"; ---14
when "1111" =>
Seven_Segment <= "0111000"; ---15
when others =>
Seven_Segment <= "1111111"; ---null
end case;
end if;
Anod_out <= Anod_in;
 
end process;

end Behavioral;
