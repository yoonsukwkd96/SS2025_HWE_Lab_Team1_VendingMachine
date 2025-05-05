
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_addsub is
end tb_addsub;

architecture Behavioral of tb_addsub is
    component addsub
        port(
            A0, A1, A2, A3 : in bit;
            B0, B1, B2, B3 : in bit;
            mode           : in bit;
            Sum0, Sum1, Sum2, Sum3 : out bit;
            Cout           : out bit
        );
    end component;

    signal A0, A1, A2, A3 : bit := '0';
    signal B0, B1, B2, B3 : bit := '0';
    signal mode           : bit := '0';
    signal Sum0, Sum1, Sum2, Sum3 : bit;
    signal Cout           : bit;

begin
    UUT: addsub port map(
        A0 => A0, A1 => A1, A2 => A2, A3 => A3,
        B0 => B0, B1 => B1, B2 => B2, B3 => B3,
        mode => mode,
        Sum0 => Sum0, Sum1 => Sum1, Sum2 => Sum2, Sum3 => Sum3,
        Cout => Cout
    );

    process
    begin
        -- Test Case 1: Add 3 (0011) + 2 (0010)
        A3 <= '0'; A2 <= '0'; A1 <= '1'; A0 <= '1';
        B3 <= '0'; B2 <= '0'; B1 <= '1'; B0 <= '0';
        mode <= '0'; -- Add
        wait for 10 ns;

        -- Test Case 2: Subtract 5 (0101) - 3 (0011)
        A3 <= '0'; A2 <= '1'; A1 <= '0'; A0 <= '1';
        B3 <= '0'; B2 <= '0'; B1 <= '1'; B0 <= '1';
        mode <= '1'; -- Subtract
        wait for 10 ns;

        -- Test Case 3: Subtract 4 (0100) - 7 (0111) (Expect negative result in 2's complement)
        A3 <= '0'; A2 <= '1'; A1 <= '0'; A0 <= '0';
        B3 <= '0'; B2 <= '1'; B1 <= '1'; B0 <= '1';
        mode <= '1';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;