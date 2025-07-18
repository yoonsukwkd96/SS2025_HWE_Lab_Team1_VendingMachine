library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register8bit is
port(Ai: in std_logic_vector(7 downto 0);
     Bo: out std_logic_vector(7 downto 0);
     clk: in std_logic
);
end register8bit;

architecture behavior of register8bit is

component DFF Port (
        clk : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC;
        Qn  : out STD_LOGIC
    );
end component;

begin
    DFF0: DFF port map(clk => clk, D => Ai(0), Q => Bo(0));
    DFF1: DFF port map(clk => clk, D => Ai(1), Q => Bo(1));
    DFF2: DFF port map(clk => clk, D => Ai(2), Q => Bo(2));
    DFF3: DFF port map(clk => clk, D => Ai(3), Q => Bo(3));
    DFF4: DFF port map(clk => clk, D => Ai(4), Q => Bo(4));
    DFF5: DFF port map(clk => clk, D => Ai(5), Q => Bo(5));
    DFF6: DFF port map(clk => clk, D => Ai(6), Q => Bo(6));
    DFF7: DFF port map(clk => clk, D => Ai(7), Q => Bo(7));

end behavior;

