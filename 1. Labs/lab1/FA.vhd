entity full_adder is
Port (A,B,Ci:in bit;
C,S:out bit);
end full_adder;
architecture behavior of full_adder is
signal Sn,Co1,Co2: bit;
component add1_half
port (Ai,Bi:in bit;
      Co,So:out bit);
end component;
begin
U1: add1_half port map (Ai=>A,Bi=>B,So=>Sn,Co=>Co2);
U2: add1_half port map (Ai=>Ci,Bi=>Sn,So=>S,Co=>Co1);
C <= Co1 or Co2;
 end behavior;
