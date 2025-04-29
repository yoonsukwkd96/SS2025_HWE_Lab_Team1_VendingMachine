library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tb_fulladder is

end tb_fulladder;

architecture test of tb_fulladder is 
signal A,B, Cin:STD_LOGIC := '0';
signal Sum,Cout :STD_LOGIC;
begin
entity work.fulladder port map(
A=>A,
B=>B,
Cin=>Cin,
Sum=>Sum,
Cout=>Cout
);

process
begin
A <= '0'; B <= '0'; Cin <= '0'; wait for 10 ns;
        A <= '0'; B <= '0'; Cin <= '1'; wait for 10 ns;
        A <= '0'; B <= '1'; Cin <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; Cin <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; Cin <= '0'; wait for 10 ns;
        A <= '1'; B <= '0'; Cin <= '1'; wait for 10 ns;
        A <= '1'; B <= '1'; Cin <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; Cin <= '1'; wait for 10 ns;
wait;
end process;
end test;
