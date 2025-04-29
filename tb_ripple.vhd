library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ripple is
end tb_ripple;

architecture behavior of tb_ripple is
signal A0, A1, A2, A3: BIT := '0';
signal B0, B1, B2, B3: BIT := '0';
signal Cin: BIT := '0';
signal Sum0, Sum1, Sum2, Sum3: BIT;
signal Cout: BIT;

component ripple
port (
    A0, A1, A2, A3: in BIT;
    B0, B1, B2, B3: in BIT;
    Cin: in BIT;
    Sum0, Sum1, Sum2, Sum3: out BIT;
    Cout: out BIT
);
end component;

begin
UUT: ripple port map (
    A0 => A0, A1 => A1, A2 => A2, A3 => A3,
    B0 => B0, B1 => B1, B2 => B2, B3 => B3,
    Cin => Cin,
    Sum0 => Sum0, Sum1 => Sum1, Sum2 => Sum2, Sum3 => Sum3,
    Cout => Cout
);

stimulus: process
begin
    -- Driving signals **sequentially** (avoiding multiple assignments outside a process)
    A0 <= '0'; A1 <= '0'; A2 <= '0'; A3 <= '0';
    B0 <= '0'; B1 <= '0'; B2 <= '0'; B3 <= '0';
    Cin <= '0';
    wait for 10 ns;

    A0 <= '1'; A1 <= '0'; A2 <= '0'; A3 <= '0';
    B0 <= '1'; B1 <= '0'; B2 <= '0'; B3 <= '0';
    Cin <= '0';
    wait for 10 ns;

    A0 <= '1'; A1 <= '0'; A2 <= '1'; A3 <= '0';
    B0 <= '1'; B1 <= '1'; B2 <= '0'; B3 <= '0';
    Cin <= '0';
    wait for 10 ns;

    A0 <= '1'; A1 <= '1'; A2 <= '1'; A3 <= '1';
    B0 <= '1'; B1 <= '1'; B2 <= '1'; B3 <= '1';
    Cin <= '0';
    wait for 10 ns;

    A0 <= '0'; A1 <= '1'; A2 <= '0'; A3 <= '1';
    B0 <= '1'; B1 <= '0'; B2 <= '1'; B3 <= '0';
    Cin <= '0';
    wait for 10 ns;

    wait; -- Prevents process from terminating
end process;
end behavior;
