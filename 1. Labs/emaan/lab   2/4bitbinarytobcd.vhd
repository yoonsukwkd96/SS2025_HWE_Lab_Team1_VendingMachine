library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity binary_bcd is
port(
num: in integer range 0 to 15;
tens: out integer range 0 to 1;
ones: out integer range 0 to 9);
end binary_bcd;
architecture behavioral of binary_bcd is
begin 
process(num)
begin
case num is 
when 0 => tens<=0; ones <= 0;
when 1 => tens<=0; ones <= 1;
when 2 => tens<=0; ones <= 2;
when 3 => tens<=0; ones <= 3;
when 4 => tens<=0; ones <= 4;
when 5 => tens<=0; ones <= 5;
when 6 => tens<=0; ones <= 6;
when 7 => tens<=0; ones <= 7;
when 8 => tens<=0; ones <= 8;
when 9 => tens<=0; ones <= 9;
when 10 => tens<=1; ones <= 0;
when 11 => tens<=1; ones <= 1;
when 12 => tens<=1; ones <= 2;
when 13 => tens<=1; ones <= 3;
when 14 => tens<=1; ones <= 4;
when 15 => tens<=1; ones <= 5;
 when others => tens<=0; ones<=0;
end case;
end process;
end behavioral;