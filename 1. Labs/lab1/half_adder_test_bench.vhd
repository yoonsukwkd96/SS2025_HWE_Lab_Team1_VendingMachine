entity test is 
end test;

architecture bench of test is

component add1_half 
port(Ai, Bi:in bit;
Co, So:out bit);
end component;

signal A_TB,B_TB :bit;
signal C_TB,S_TB :bit;

begin
DUT1: add1_half port map(Ai=>A_TB,
                           Bi=>B_TB,
                           Co=>C_TB,
                           So=>S_TB);
process
begin
A_TB <= '0';
B_TB <= '0';
wait for 10ps;
A_TB <= '1';
B_TB <= '0';
wait for 10ps;
A_TB <= '0';
B_TB <= '1';
wait for 10ps;
A_TB <= '1';
B_TB <= '1';
wait for 10ps;
end process;
end bench;
