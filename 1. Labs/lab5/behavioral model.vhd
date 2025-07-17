library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_led is
end tb_counter_led;

architecture behavior of tb_counter_led is

    
    signal clk_tb  : std_logic := '0';
    signal q_tb    : std_logic_vector(2 downto 0);
    signal led     : std_logic;

    
    component counter3bit
        port(
            clk : in std_logic;
            q   : out std_logic_vector(2 downto 0)
        );
    end component;

    constant clk_period : time := 10 ns;

begin

 
    UUT: counter3bit
        port map(
            clk => clk_tb,
            q   => q_tb
        );

   
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

   
    led <= '1' when q_tb = "111" else '0';

end behavior;

