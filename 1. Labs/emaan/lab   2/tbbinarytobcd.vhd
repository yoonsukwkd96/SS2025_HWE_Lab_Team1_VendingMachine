library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tbbinary_bcd is
end tbbinary_bcd;
architecture test of tbbinary_bcd is
signal num: integer range 0 to 15:= 0;
signal tens: integer range 0 to 1;
signal ones: integer range 0 to 9;
component binary_bcd
port (
 num: integer range 0 to 15;
 tens: integer range 0 to 1;
ones: integer range 0 to 9
);
end component;

begin 
binary_bcd_inst:binary_bcd
port map(
num => num,
tens => tens,
ones => ones
);

test_process:process
begin
for i in 0 to 15 loop
num<=i;
wait for 10 ns;
end loop;
wait;
end process;
end test;