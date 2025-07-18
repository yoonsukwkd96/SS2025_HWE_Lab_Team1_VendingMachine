library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity a_counter is
port(clk: in std_logic;
     q_out : out STD_LOGIC_VECTOR(2 downto 0)
);
end a_counter;

architecture structural of a_counter is

    component JKff
        Port (
            clk : in  STD_LOGIC;
            j   : in  STD_LOGIC;
            k   : in  STD_LOGIC;
            q   : out STD_LOGIC;
            qn  : out STD_LOGIC
        );
    end component;

    signal q0, q1, q2 : STD_LOGIC;
    signal qn_dummy   : STD_LOGIC; 

begin

 
    jk0: JKff port map(
        clk => clk,
        j   => '1',
        k   => '1',
        q   => q0,
        qn  => qn_dummy
    );

    jk1: JKff port map(
        clk => q0,
        j   => '1',
        k   => '1',
        q   => q1,
        qn  => qn_dummy
    );

   
    jk2: JKff port map(
        clk => q1,
        j   => '1',
        k   => '1',
        q   => q2,
        qn  => qn_dummy
    );

    
    q_out <= q2 & q1 & q0;

end structural;