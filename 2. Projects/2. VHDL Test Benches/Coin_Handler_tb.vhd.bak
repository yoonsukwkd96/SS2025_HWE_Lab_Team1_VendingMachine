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
    signal inserted_amount_tb : unsigned(9 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    DUT: Coin_Handler
        port map (
            clk             => clk_tb,
            reset           => reset_tb,
            BTNU            => BTNU_tb,
            BTNL            => BTNL_tb,
            BTNR            => BTNR_tb,
            BTND            => BTND_tb,
            inserted_amount => inserted_amount_tb
        );

    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc : process
    begin
        -- Initial Reset
        reset_tb <= '1';
        wait for CLK_PERIOD * 2;
        reset_tb <= '0';
        wait for CLK_PERIOD * 2;

        -- Test Case 1: Insert 10 cents
        BTNU_tb <= '1'; wait for CLK_PERIOD * 2; BTNU_tb <= '0';
        wait for CLK_PERIOD * 5;

        -- Test Case 2: Insert 20 cents
        BTNL_tb <= '1'; wait for CLK_PERIOD * 2; BTNL_tb <= '0';
        wait for CLK_PERIOD * 5;

        -- Test Case 3: Insert 50 cents
        BTNR_tb <= '1'; wait for CLK_PERIOD * 2; BTNR_tb <= '0';
        wait for CLK_PERIOD * 5;

        -- Test Case 4: Insert 1 Euro (100 cents)
        BTND_tb <= '1'; wait for CLK_PERIOD * 2; BTND_tb <= '0';
        wait for CLK_PERIOD * 5;

        -- End simulation
        assert false report "Coin_Handler test finished." severity failure;
    end process;

end Behavioral;

