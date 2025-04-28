library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_halfadder is
end tb_halfadder:

architecture sim of tb_halfadder is
signal A,B,Sum, Carry : STD_LOGIC;
begin
port map (A => A, B=> B, Sum => Sum, Carry => Carry);
process
begin
A <=`0´; B  <=`0´; wait for 10 ns;
A <=`0´; B  <=`1´;  wait for 10 ns;
A <=`1´; B  <=`0´;  wait for 10 ns;
A <=`1´; B  <=`1´;  wait for 10 ns;
wait;
end process;
end sim;