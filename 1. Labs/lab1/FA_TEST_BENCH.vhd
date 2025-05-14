entity test is
end test;

architecture bench1 of test is

component full_adder
Port (A,B,Ci:in bit;
C,S:out bit);
end component;

signal A_TB1,B_TB1,Ci_TB1: bit;
signal Co_TB1,S_TB1: bit;

begin
DUT1 : full_adder port map(A=>A_TB1,
                           B=>B_TB1,
                           Ci=>Ci_TB1,
                           S=>S_TB1,
                           C=>Co_TB1);

process
begin
A_TB1 <= '0';
B_TB1 <= '0';
Ci_TB1<= '0';
wait for 10ps;
A_TB1 <= '0';
B_TB1 <= '1';
Ci_TB1<= '0';
wait for 10ps;
A_TB1 <= '0';
B_TB1 <= '1';
Ci_TB1<= '1';
wait for 10ps;
A_TB1 <= '0';
B_TB1 <= '0';
Ci_TB1<= '1';
wait for 10ps;
A_TB1 <= '1';
B_TB1 <= '0';
Ci_TB1<= '0';
wait for 10ps;
A_TB1 <= '1';
B_TB1 <= '1';
Ci_TB1<= '0';
wait for 10ps;
A_TB1 <= '1';
B_TB1 <= '1';
Ci_TB1<= '1';
wait for 10ps;
A_TB1 <= '1';
B_TB1 <= '0';
Ci_TB1<= '1';
wait for 10ps;
end process;
end bench1;