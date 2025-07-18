library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_led_top is
end tb_counter_led_top;

architecture testbench of tb_counter_led_top is

    
    signal clk_tb : std_logic := '0';
    signal led_tb : std_logic;

   
    component counter_led_top
        port (
            clk : in std_logic;
            led : out std_logic
        );
    end component;

    constant clk_period : time := 10 ns;

begin

  
    UUT: counter_led_top
        port map (
            clk => clk_tb,
            led => led_tb
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


    stim_proc : process
    begin
        wait for 150 ns;
        assert false report "Simulation finished." severity note;
        wait;
    end process;

end testbench;

