entity BCD_to_7seg is
port(A1: in bit_vector(3 downto 0);
     a,b,c,d,e,f,g: out bit);
end BCD_to_7seg;

architecture behavior of BCD_to_7seg is

begin
    a <= '0' when (A1 = "0000" or A1 = "0010" or A1 = "0011" or A1 = "0101" or A1 = "0110" or A1 = "0111" or A1 = "1000" or A1 = "1001") else '1';
    b <= '1' when (A1 = "0101" or A1 = "0110") else '0';
    c <= '1' when (A1 = "0010") else '0';
    d <= '1' when (A1 = "0001" or A1 = "0100" or A1 = "0111") else '0';
    e <= '0' when (A1 = "0000" or A1 = "0010" or A1 = "0110" or A1 = "1000") else '1';
    f <= '0' when (A1 = "0000" or A1 = "0100" or A1 = "0101" or A1 = "0110" or A1 = "1000" or A1 = "1001") else '1';
    g <= '1' when (A1 = "0000" or A1 = "0001" or A1 = "0111") else '0';
end behavior;
-- g is the one stick in middle,abcdef from top clock direction --- reminder from Leano
