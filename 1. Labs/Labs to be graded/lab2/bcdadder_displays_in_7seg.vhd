entity BCD_Addder_display is
port(C1: in bit_vector(3 downto 0);
     C2: in bit_vector(3 downto 0);
     D1: out bit_vector(6 downto 0);
     D2: out bit_vector(6 downto 0));
end BCD_Addder_display;

architecture behavior of BCD_Addder_display is


signal R1,R2,R3,R4,R11,R22,R33,R44: bit;
signal R_bin   : bit_vector(3 downto 0);
signal F_bin : bit_vector(3 downto 0);
signal sum_bin    : bit_vector(3 downto 0);  -- ?????????
signal need_carry : bit;
signal carry   : bit;
signal carry2  : bit;

component RA
port( A1,A2,A3,A4,B1,B2,B3,B4,Cin: in bit;
      S1,S2,S3,S4,Cout: out bit);
end component;

component BCD_to_7seg
port(A1: in bit_vector(3 downto 0);
     a,b,c,d,e,f,g: out bit);
end component;

begin

DUT1:RA port map (A1=>C1(0),A2=>C1(1),A3=>C1(2),A4=>C1(3),B1=>C2(0),B2=>C2(1),B3=>C2(2),B4=>C2(3),Cin=>'0',Cout=>carry,S1=>R1,S2=>R2,S3=>R3,S4=>R4);
DUT2:RA port map (A1=>R1,A2=>R2,A3=>R3,A4=>'0',B1=>'0',B2=>'1',B3=>'1',B4=>'0',Cin=>'0',Cout=>carry2,S1=>R11,S2=>R22,S3=>R33,S4=>R44); 
R_bin <= R44 & R33 & R22 & R11 when 
    (R4 & R3 & R2 & R1 = "1010" or 
     R4 & R3 & R2 & R1 = "1011" or 
     R4 & R3 & R2 & R1 = "1100" or 
     R4 & R3 & R2 & R1 = "1101" or 
     R4 & R3 & R2 & R1 = "1110" or 
     R4 & R3 & R2 & R1 = "1111") else R4&R3&R2&R1;
sum_bin <= R4&R3&R2&R1; need_carry <= '1' when 
    (sum_bin = "1010" or sum_bin = "1011" or 
     sum_bin = "1100" or sum_bin = "1101" or 
     sum_bin = "1110" or sum_bin = "1111") 
else '0';
F_bin <= "0001" when (carry = '1' or need_carry = '1') else "0000";
DUT4:BCD_to_7seg port map(A1=>R_bin,a => D1(6), b => D1(5), c => D1(4), d => D1(3),
  e => D1(2), f => D1(1), g => D1(0));
DUT5:BCD_to_7seg port map(A1=>F_bin,a => D2(6), b => D2(5), c => D2(4), d => D2(3),
  e => D2(2), f => D2(1), g => D2(0));

end behavior;
