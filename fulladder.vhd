library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fulladder is
Port(
	A: in STD_LOGIC;
	B: in STD_LOGIC;
	Cin: in STD_LOGIC;
	Sum: out STD_LOGIC;	
	Cout: out STD_LOGIC
);
end fulladder;

architecture structural of fulladder is
component halfadder 
Port(
	A: in STD_LOGIC;
	B: in STD_LOGIC;
	Sum: out STD_LOGIC;
	Carry: out STD_LOGIC
);
end component;
signal S1,S2,C1,C2: STD_LOGIC;
begin
H1 : halfadder port map(
	A => A,
	B => B,
	Sum => S1,
	Carry => C1
);
H2 : halfadder port map(
	A => S1,
	B => Cin,
	Sum => Sum,
	Carry => C2
);
Cout <= C1 OR C2;
end structural;
