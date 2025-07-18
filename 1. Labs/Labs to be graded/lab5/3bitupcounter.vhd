library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter3bit is
    port(
        clk : in std_logic;
        q   : out std_logic_vector(2 downto 0)
    );
end counter3bit;

architecture structural of counter3bit is

    component JKff
        port(
            clk : in std_logic;
            j   : in std_logic;
            k   : in std_logic;
            q   : out std_logic;
            qn  : out std_logic
        );
    end component;

    signal q0, q1, q2    : std_logic;
    signal qn0, qn1, qn2 : std_logic;

    -- ??????????????
    signal j2_input : std_logic;

begin

    -- Q0: toggle every clock
    FF0: JKff
        port map(
            clk => clk,
            j   => '1',
            k   => '1',
            q   => q0,
            qn  => qn0
        );

    -- Q1: toggle when q0 = '1'
    FF1: JKff
        port map(
            clk => clk,
            j   => q0,
            k   => q0,
            q   => q1,
            qn  => qn1
        );

    -- Q2: toggle when q0 AND q1 = '1'
    j2_input <= q0 and q1;

    FF2: JKff
        port map(
            clk => clk,
            j   => j2_input,
            k   => j2_input,
            q   => q2,
            qn  => qn2
        );

    q <= q2 & q1 & q0;

end structural;

