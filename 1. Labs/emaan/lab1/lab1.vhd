
entity FullAdderexample is
    port (
        A, B ,Cin: in  bit;
           S, Cout: out bit);
end entity FullAdderexample;

architecture behavior of  FullAdderexample is
begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (B and Cin) or (A and Cin);
end architecture behavior;