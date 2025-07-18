entity RA is
port( A1,A2,A3,A4,B1,B2,B3,B4,Cin: in bit;
      S1,S2,S3,S4,Cout: out bit);
end RA;

architecture behavior of RA is

signal C1,C2,C3: bit;

component full_adder
Port (A,B,Ci:in bit;
C,S:out bit);
end component;

begin
U1: full_adder port map(Ci=>Cin,A=>A1,B=>B1,C=>C1,S=>S1);
U2:full_adder port map(Ci=>C1,A=>A2,B=>B2,C=>C2,S=>S2);
U3: full_adder port map(Ci=>C2,A=>A3,B=>B3,C=>C3,S=>S3);
U4: full_adder port map(Ci=>C3,A=>A4,B=>B4,C=>Cout,S=>S4);

end behavior;