library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Coin_Handler_tb is
end Coin_Handler_tb;

architecture Behavioral of Coin_Handler_tb is

    component Coin_Handler is
        Port (
            clk             : in  std_logic;
            reset           : in  std_logic;
            BTNU            : in  std_logic;
            BTNL            : in  std_logic;
            BTNR            : in  std_logic;
            BTND            : in  std_logic;
            inserted_amount : out unsigned(9 downto 0)
        );
    end component;

    signal clk_tb    : std_logic := '0';
    signal reset_tb  : std_logic := '0';
    signal BTNU_tb   : std_logic := '0';
    signal BTNL_tb   : std_logic := '0';
    signal BTNR_tb   : std_logic := '0';
    signal BTND_tb   : std_logic := '0';
    signal amount_tb : unsigned(9 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate DUT
    DUT: Coin_Handler
        port map (
            clk             => clk_tb,
            reset           => reset_tb,
            BTNU            => BTNU_tb,
            BTNL            => BTNL_tb,
            BTNR            => BTNR_tb,
            BTND            => BTND_tb,
            inserted_amount => amount_tb
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus and verification process
    stim_proc : process
    begin
        -- Reset system
        reset_tb <= '1';
        wait for CLK_PERIOD * 2;
        reset_tb <= '0';
        wait for CLK_PERIOD * 2;

        -- TC1: Insert 10 cents (BTNU)
        BTNU_tb <= '1';
        wait for CLK_PERIOD * 2;
        BTNU_tb <= '0';
        wait for CLK_PERIOD * 2;
        assert amount_tb = to_unsigned(10, 10)
            report "TC1 Failed: Expected 10, got " & integer'image(to_integer(amount_tb)) severity error;

        -- TC2: Insert 20 cents (BTNL)
        BTNL_tb <= '1';
        wait for CLK_PERIOD * 2;
        BTNL_tb <= '0';
        wait for CLK_PERIOD * 2;
        assert amount_tb = to_unsigned(30, 10)
            report "TC2 Failed: Expected 30, got " & integer'image(to_integer(amount_tb)) severity error;

        -- TC3: Insert 50 cents (BTNR)
        BTNR_tb <= '1';
        wait for CLK_PERIOD * 2;
        BTNR_tb <= '0';
        wait for CLK_PERIOD * 2;
        assert amount_tb = to_unsigned(80, 10)
            report "TC3 Failed: Expected 80, got " & integer'image(to_integer(amount_tb)) severity error;

        -- TC4: Insert 100 cents (BTND)
        BTND_tb <= '1';
        wait for CLK_PERIOD * 2;
        BTND_tb <= '0';
        wait for CLK_PERIOD * 2;
        assert amount_tb = to_unsigned(180, 10)
            report "TC4 Failed: Expected 180, got " & integer'image(to_integer(amount_tb)) severity error;

        -- Done
        report "All Coin_Handler test cases passed." severity note;
        wait;
    end process;

end Behavioral;

