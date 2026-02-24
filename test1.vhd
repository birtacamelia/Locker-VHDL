----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 08:38:47 PM
-- Design Name: 
-- Module Name: test1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


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

entity introdu_cod is
    Port (  clk, btn_up,btn_down,res,btn_add,en_test: in std_logic;
            reg1_c,reg2_c,reg3_c: out std_logic_vector(3 downto 0);
            introdu_caracter,blocat:out std_logic;
            output_c: out STD_logic_vector(0 to 6);
            output_a: out STD_logic_vector(3 downto 0));
end introdu_cod;

architecture Behavioral of introdu_cod is
component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
  end component;
component BCD_decod is
Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
       Seven_Segment : out STD_LOGIC_VECTOR (0 to 6);
       Anod_in : in STD_LOGIC_VECTOR (3 DOWNTO 0);
       Anod_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;
component numarator_up_down is
  Port( clk,res, btn_up,btn_down,en: in std_logic;
       count: out std_logic_vector(3 downto 0));
  end component;
 component comparator_cifre is
  Port( cif1,cif2,cif3: in std_logic_vector (3 downto 0);
       diferit: out std_logic); 
 end component;
signal bdin: std_logic_vector(3 downto 0);
signal adauga_cifra: std_logic;
signal introdu_caracter_int ,blocat_int: std_logic := '0';
signal reg1,reg2,reg3: std_logic_vector(3 downto 0);
signal anodinput: std_logic_vector(3 downto 0);
signal displayCounter: std_logic_vector(1 downto 0) := "00";
signal count: std_logic_vector(16 downto 0) := (others => '0');
signal careCounter:std_logic_vector(1 downto 0):="00";
signal en1,en2,en3,diferit:std_logic;
begin
en1<='1' when careCounter="01" else '0';
en2<='1' when careCounter="10" else '0';
en3<='1' when careCounter="11" else '0';

c1: MPG port map(btn_add,clk,adauga_cifra);
c2: BCD_decod port map(bdin ,output_c,anodinput, output_a);
c4: numarator_up_down port map(
clk => clk,
res => res, 
btn_up=>btn_up,
btn_down=>btn_down,
en=>en1,
count=>reg1);
c5: numarator_up_down port map(
clk => clk,
res => res, 
btn_up=>btn_up,
btn_down=>btn_down,
en=>en2,
count=>reg2);
c6: numarator_up_down port map(
clk => clk,
res => res, 
btn_up=>btn_up,
btn_down=>btn_down,
en=>en3,
count=>reg3);
c7: comparator_cifre port map(reg1,reg2,reg3,diferit);
process(clk)
begin
    if rising_edge(clk) then
     if res = '1' then
                careCounter <= "00";
              blocat_int<= '0';
                introdu_caracter_int <= '0';
            elsif en_test = '1' then
        if adauga_cifra = '1' then 
            introdu_caracter_int <= '1';
            if careCounter = "11" then
                if diferit = '0' then
                    careCounter <= "00";
                    introdu_caracter_int <= '0';
                    blocat_int <= '0';
                else
                    careCounter <= "00";
                   blocat_int <= '1';
                    introdu_caracter_int <= '0';
                 
                end if;
            else
                careCounter <= careCounter + 1;
            end if;
        elsif careCounter = "00" then
            introdu_caracter_int <= '0';
       end if;    
        end if;
    end if;
end process;

process(clk)
constant max_count: std_logic_vector(16 downto 0):= "11000011010100000"; 
begin
    if rising_edge(clk) then
        count <= count + 1;
        if count = max_count then
            count <= (others => '0');

        
            case displayCounter is
                when "00" =>
                 if careCounter>="01" then
                    bdin <= reg1;
                    anodinput <= "0111";  -- activeaz primul display
                  else
                     anodinput <= "1111";
                    end if;
                when "01" =>
                    if careCounter = "10" or careCounter = "11" then
                        bdin <= reg2;
                        anodinput <= "1011"; -- al doilea display
                    else
                        anodinput <= "1111"; -- nu afisez nimic
                    end if;
                when "10" =>
                    if careCounter = "11" then
                        bdin <= reg3;
                        anodinput <= "1101"; -- al treilea display
                
                    else
                        anodinput <= "1111"; -- nu afisez nimic
                    end if;
                when others =>
                    anodinput <= "1111";
            end case;

          if displayCounter = "10" then
    displayCounter <= "00";
else
    displayCounter <= displayCounter + 1;
end if;

        end if;
    end if;
end process;
   blocat <= blocat_int;
introdu_caracter <= introdu_caracter_int;
 reg1_c<=reg1;
 reg2_c<=reg2;
 reg3_c<=reg3;
end Behavioral;
