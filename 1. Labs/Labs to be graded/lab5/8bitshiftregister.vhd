library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister8 is
    Port (
        clk   : in  STD_LOGIC;
        Din   : in  STD_LOGIC;
        Dout  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ShiftRegister8;

architecture Structural of ShiftRegister8 is

    component DFF
        Port (
            clk : in STD_LOGIC;
            D   : in STD_LOGIC;
            Q   : out STD_LOGIC;
            Qn  : out STD_LOGIC
        );
    end component;

    signal q0, q1, q2, q3, q4, q5, q6, q7 : STD_LOGIC;
    signal qn0, qn1, qn2, qn3, qn4, qn5, qn6, qn7 : STD_LOGIC;

begin

    DFF0: DFF port map(clk => clk, D => Din,  Q => q0, Qn => qn0);
    DFF1: DFF port map(clk => clk, D => q0,   Q => q1, Qn => qn1);
    DFF2: DFF port map(clk => clk, D => q1,   Q => q2, Qn => qn2);
    DFF3: DFF port map(clk => clk, D => q2,   Q => q3, Qn => qn3);
    DFF4: DFF port map(clk => clk, D => q3,   Q => q4, Qn => qn4);
    DFF5: DFF port map(clk => clk, D => q4,   Q => q5, Qn => qn5);
    DFF6: DFF port map(clk => clk, D => q5,   Q => q6, Qn => qn6);
    DFF7: DFF port map(clk => clk, D => q6,   Q => q7, Qn => qn7);

    Dout <= q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;

end Structural;

