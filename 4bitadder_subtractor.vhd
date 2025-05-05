library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addsub is
    port(
        A0, A1, A2, A3 : in bit;
        B0, B1, B2, B3 : in bit;
        mode           : in bit; -- 0 for add, 1 for subtract
        Sum0, Sum1, Sum2, Sum3 : out bit;
        Cout          : out bit
    );
end addsub;

architecture Behavioral of addsub is
    component ripple
        port(
            A0, A1, A2, A3 : in bit;
            B0, B1, B2, B3 : in bit;
            Cin           : in bit;
            Sum0, Sum1, Sum2, Sum3 : out bit;
            Cout          : out bit
        );
    end component;

    signal B0_xor, B1_xor, B2_xor, B3_xor : bit;

begin
    -- XOR B inputs with mode: if mode = 1 (subtract), invert B
    B0_xor <= B0 xor mode;
    B1_xor <= B1 xor mode;
    B2_xor <= B2 xor mode;
    B3_xor <= B3 xor mode;

    U1: ripple port map(
        A0 => A0, A1 => A1, A2 => A2, A3 => A3,
        B0 => B0_xor, B1 => B1_xor, B2 => B2_xor, B3 => B3_xor,
        Cin => mode,
        Sum0 => Sum0, Sum1 => Sum1, Sum2 => Sum2, Sum3 => Sum3,
        Cout => Cout
    );

end Behavioral;