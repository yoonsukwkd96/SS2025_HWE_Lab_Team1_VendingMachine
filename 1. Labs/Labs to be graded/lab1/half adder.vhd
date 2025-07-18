entity add1_half is
port(Ai,Bi :in bit;
So,Co :out bit 
);
end add1_half;

architecture behavior of add1_half is
begin
So <= Ai xor Bi;
Co <= Ai and Bi;

end architecture;  