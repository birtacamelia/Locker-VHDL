----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 07:13:38 PM
-- Design Name: 
-- Module Name: PROIECT - Behavioral
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

entity PROIECT is
 Port(  btn_add,btn_up, btn_down,clk,reset:in  std_logic;
       liber_ocupat: out STD_LOGIC ;
	   introdu_caractere: out STD_LOGIC ;
	   output_a :out std_logic_vector(3 downto 0);
	   output_c: out std_logic_vector(0 to 6));
end PROIECT;

architecture Behavioral of PROIECT is
  component comparator_cod is
  Port ( en :in std_logic;
  reg1,reg2,reg3,reg4,reg5,reg6: in std_logic_vector(3 downto 0);
       deblocat :out std_logic);
     end component;
 component introdu_cod is
    Port (  clk, btn_up,btn_down,btn_add,res,en_test: in std_logic;
            reg1_c,reg2_c,reg3_c: out std_logic_vector(3 downto 0);
            introdu_caracter,blocat:out std_logic;
            output_c: out STD_logic_vector(0 to 6);
            output_a: out STD_logic_vector(3 downto 0));
 end component;
  signal introdu1, introdu2, blocat1, blocat2,liber_ocupat_int,deblocat, introdu_caractere_int: std_logic;
    signal en_test2,reset_local2,  reset_local1 : std_logic := '0';
    signal enc: std_logic := '0';
    signal en_test1: std_logic:='1';
    signal reg1, reg2, reg3, reg4, reg5, reg6 : std_logic_vector(3 downto 0);
    signal output_c_int,output_c_int1 : std_logic_vector(0 to 6);
    signal output_a_int, output_a_int1 : std_logic_vector(3 downto 0);

begin

    C1: introdu_cod port map (
        clk => clk,
        btn_up => btn_up,
        btn_down => btn_down,
        btn_add => btn_add,
        en_test => en_test1,
        res => reset_local1,
        reg1_c => reg1,
        reg2_c => reg2,
        reg3_c => reg3,
        introdu_caracter => introdu1,
        blocat => blocat1,
        output_c => output_c_int,
        output_a => output_a_int
    );

    C2: introdu_cod port map (
        clk => clk,
        btn_up => btn_up,
        btn_down => btn_down,
        btn_add => btn_add,
        en_test => en_test2,
        res =>reset_local2,
        reg1_c => reg4,
        reg2_c => reg5,
        reg3_c => reg6,
        introdu_caracter => introdu2,
        blocat => blocat2,
        output_c => output_c_int1,
        output_a => output_a_int1
    );
    C3: comparator_cod port map (
    en=>enc,
    reg1=>reg1,
    reg2=>reg2,
    reg3=>reg3,
    reg4=>reg4,
    reg5=>reg5,
    reg6=>reg6,
    deblocat=>deblocat);
 process(clk)
 begin
    if rising_edge(clk) then
        if reset = '1' then
           reset_local2<='1';
           reset_local1<='1';
            en_test1 <= '1';
            en_test2 <= '0';
            enc <= '0';
            liber_ocupat_int <= '0';
            introdu_caractere_int<='0';
        elsif blocat1 = '1' and btn_add = '1' then
            en_test1 <= '0';
            en_test2 <= '1';
             liber_ocupat_int <= '1';
          
        elsif blocat1 = '1' and blocat2 = '1' and enc='0' then
            enc <= '1';
            en_test2<='0';
        elsif blocat1 = '1' and blocat2 = '1' and enc='1' then
            if deblocat = '1'   then
                liber_ocupat_int <= '0';
                enc<='0';
                en_test1<='1';
                en_test2<='0';
                reset_local1<='1';
           
            else
                liber_ocupat_int <= '1';
                reset_local2<='1';
                 en_test2<='1';
                 en_test1<='0';
                  enc<='0';
            end if;
            end if;
       if reset_local2 = '1' then
            reset_local2 <= '0';
       end if;
       if reset_local1 = '1' then
            reset_local1 <= '0';
       end if;
    end if;
end process;

    liber_ocupat <=liber_ocupat_int;      
    introdu_caractere <= introdu1 or introdu2;
   process
      begin
    if en_test1='1' then
    output_c <= output_c_int ;
    output_a <= output_a_int ;
    end if;
      if en_test2='1' then
    output_c <= output_c_int1 ;
    output_a <= output_a_int1 ;
    end if;
    end process;
end Behavioral;