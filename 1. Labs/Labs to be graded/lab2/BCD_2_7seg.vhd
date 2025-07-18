entity BCD_2_integer is
port(A1: in bit_vector(3 downto 0);
     A2: in bit_vector(3 downto 0);
     B1: out integer;
     B2: out integer);
end BCD_2_integer;

architecture behavior of BCD_2_7seg is

function bit_to_integer(x : bit) return integer is
begin
if x='1' then return 1;
else return 0;
end if;
end;

begin
B1 <= bit_to_integer(A1(0))*1 + bit_to_integer(A1(1))*2 +bit_to_integer(A1(2))*4 + bit_to_integer(A1(3))*8;
B2 <= bit_to_integer(A2(0))*1 + bit_to_integer(A2(1))*2 +bit_to_integer(A2(2))*4 + bit_to_integer(A2(3))*8;

end behavior;
