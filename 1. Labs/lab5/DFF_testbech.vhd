library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity test is 
end test;

architecture bench1 of test is

signal CLKtest : std_logic := '0';
signal Dtest : std_logic := '0';
signal Qtest : std_logic;
signal Qnottest : std_logic;


component DFF
Port (
        clk : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC;
        Qn  : out STD_LOGIC
    );
end component;


begin


DUT1: DFF port map( clk => clktest,
                    D   => Dtest,
                    Q   => Qtest,
                    Qn  => Qnottest);

clock_process : process
begin
    while now < 200 ns loop
        CLKtest <= '0';
        wait for 10 ns;
        CLKtest <= '1';
        wait for 10 ns;
    end loop;
    wait;
end process;

stim_proc: process
begin
    wait for 15 ns; 
    Dtest <= '1';
    wait for 40 ns;
    Dtest <= '0';
    wait for 40 ns;
    Dtest <= '1';
    wait;
end process;
end bench1;