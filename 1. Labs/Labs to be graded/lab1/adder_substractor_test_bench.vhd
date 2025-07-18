entity test is
end test;

architecture bench3 of test is

component adder_substractor
port(C1,C2,C3,C4,D1,D2,D3,D4,I1: in bit;
      S11,S22,S33,S44,Coutt: out bit);
end component;

signal C1_TB,C2_TB,C3_TB,C4_TB,D1_TB,D2_TB,D3_TB,D4_TB,I1_TB:bit;
signal S11_TB,S22_TB,S33_TB,S44_TB,Coutt_TB:bit;

begin
DUT1 : adder_substractor port map(C1=>C1_TB,
                                  C2=>C2_TB,
                                  C3=>C3_TB,
                                  C4=>C4_TB,
                                  D1=>D1_TB,
                                  D2=>D2_TB,
                                  D3=>D3_TB,
                                  D4=>D4_TB,
                                  I1=>I1_TB,
                                  S11=>S11_TB,
                                  S22=>S22_TB,
                                  S33=>S33_TB,
                                  S44=>S44_TB,
                                  Coutt=>Coutt_TB);


process
begin
C1_TB <= '0';
C2_TB <= '1';
C3_TB<= '0';
C4_TB<= '1';
I1_TB<= '1';
D1_TB <= '1';
D2_TB <= '1';
D3_TB<= '1';
D4_TB<= '0';
wait for 10ps;
C1_TB <= '1';
C2_TB <= '1';
C3_TB<= '0';
C4_TB<= '1';
I1_TB<= '0';
D1_TB <= '1';
D2_TB <= '0';
D3_TB<= '1';
D4_TB<= '1';
wait for 10ps;C1_TB <= '0';
C2_TB <= '1';
C3_TB<= '1';
C4_TB<= '0';
I1_TB<= '1';
D1_TB <= '1';
D2_TB <= '1';
D3_TB<= '1';
D4_TB<= '0';
wait for 10ps;
end process;
end bench3;