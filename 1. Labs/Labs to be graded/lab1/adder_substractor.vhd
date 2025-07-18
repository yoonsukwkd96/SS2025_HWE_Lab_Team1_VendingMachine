entity adder_substractor is
port(C1,C2,C3,C4,D1,D2,D3,D4,I1: in bit;
      S11,S22,S33,S44,Coutt: out bit);
end adder_substractor;

architecture behavior of adder_substractor is

signal M1,M2,M3,M4: bit;

component RA
port( A1,A2,A3,A4,B1,B2,B3,B4,Cin: in bit;
      S1,S2,S3,S4,Cout: out bit);
end component;





begin

M1 <= D1 xor I1;
M2 <= D2 xor I1;
M3 <= D3 xor I1;
M4 <= D4 xor I1;

U1:RA port map (A1=>C1,A2=>C2,A3=>C3,A4=>C4,S1=>S11,S2=>S22,S3=>S33,S4=>S44,Cout=>Coutt,B1=>M1,B2=>M2,B3=>M3,B4=>M4,Cin=>I1);

end behavior;
