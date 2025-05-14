entity test is
end test;

architecture bench2 of test is

component RA
port( A1,A2,A3,A4,B1,B2,B3,B4,Cin: in bit;
      S1,S2,S3,S4,Cout: out bit);
end component;

signal A1_TB,A2_TB,A3_TB,A4_TB,B1_TB,B2_TB,B3_TB,B4_TB,S1_TB,S2_TB,S3_TB,S4_TB,Cout_TB,Cin_TB: bit;

begin
DUT1: RA port map(A1 => A1_TB, A2 => A2_TB, A3 => A3_TB, A4 => A4_TB,
                  B1 => B1_TB, B2 => B2_TB, B3 => B3_TB, B4 => B4_TB,
                  S1 => S1_TB, S2 => S2_TB, S3 => S3_TB, S4 => S4_TB,
                  Cout => Cout_TB,Cin =>Cin_TB);

process
	
    begin
        -- A = 0000, B = 0000
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '0'; B3_TB <= '0'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0001
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '0'; B3_TB <= '0'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0010
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '1'; B3_TB <= '0'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0011
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '1'; B3_TB <= '0'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0100
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '0'; B3_TB <= '1'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0101
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '0'; B3_TB <= '1'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0110
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '1'; B3_TB <= '1'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 0111
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '1'; B3_TB <= '1'; B4_TB <= '0';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1000
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '0'; B3_TB <= '0'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1001
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '0'; B3_TB <= '0'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1010
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '1'; B3_TB <= '0'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1011
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '1'; B3_TB <= '0'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1100
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '0'; B3_TB <= '1'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1101
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '0'; B3_TB <= '1'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1110
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '0'; B2_TB <= '1'; B3_TB <= '1'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;

-- A = 0000, B = 1111
A1_TB <= '0'; A2_TB <= '0'; A3_TB <= '0'; A4_TB <= '0';
B1_TB <= '1'; B2_TB <= '1'; B3_TB <= '1'; B4_TB <= '1';Cin_TB <='0';
wait for 10 ns;
end process;                        
end bench2;																												
