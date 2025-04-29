library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ripple is
port(
 A0,A1,A2,A3:in  bit;
  B0,B1,B2,B3:in bit;
  Cin:in  bit;
  Sum0,Sum1,Sum2,Sum3: out bit;
   Cout: out bit
);


end ripple;

architecture Behavioral of ripple is
component fulladder
port(
A:in bit;
B:in bit;
Cin:in bit;
Sum:out bit;
Cout:out bit
);
end component;

signal c1,c2,c3:bit;
begin
FA0:fulladder port map(
A => A0,
B => B0,
Cin => Cin,
Sum => Sum0,
Cout => c1
);


FA1:fulladder port map(
A => A1,
B => B1,
Cin => C1,
Sum => Sum1,
Cout => c2
);

FA2:fulladder port map(
A => A2,
B => B2,
Cin => c2,
Sum => Sum2,
Cout => c3
);
FA3:fulladder port map(
A => A3,
B => B3,
Cin => c3,
Sum => Sum3,
Cout => Cout
);
end behavioral;
