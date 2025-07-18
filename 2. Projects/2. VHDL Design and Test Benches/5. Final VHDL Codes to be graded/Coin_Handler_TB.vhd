library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Coin_Handler_TB is
end Coin_Handler_TB;

architecture behavioral of Coin_Handler_TB is

	component Coin_Handler is
		port(
			clk : in std_logic;
			reset : in std_logic;
			BTNU : in std_logic;
			BTNL : in std_logic;
			BTNR : in std_logic;
			BTND : in std_logic;
			inserted_amount : out unsigned(9 downto 0)
		);
	end component;

	signal clk_TB 	: std_logic := '0';
	signal reset_TB	: std_logic := '0';
	signal BTNU_TB 	: std_logic := '0';
	signal BTNL_TB 	: std_logic := '0';
	signal BTNR_TB 	: std_logic := '0';
	signal BTND_TB 	: std_logic := '0';
	signal inserted_amount_TB : unsigned(9 downto 0);

	constant CLK_PERIOD : time := 10 ns;

begin

	DUT: Coin_Handler
		port map(
			clk => clk_TB,
			reset => reset_TB,
			BTNU => BTNU_TB,
			BTNL => BTNL_TB,
			BTNR => BTNR_TB,
			BTND => BTND_TB,
			inserted_amount => inserted_amount_TB
		);

	clk_process : process
	begin
		while true loop
			clk_TB <= '0';
			wait for CLK_PERIOD / 2;
			clk_TB <= '1';
			wait for CLK_PERIOD / 2;
		end loop;
	end process;

	stimulate_process : process		
	begin
		-- Initial Reset
		reset_TB <= '1';
		wait for CLK_PERIOD * 2;
		reset_TB <= '0';
		wait for CLK_PERIOD * 2;

		-- Test Case 1: Insert 10 cents / BTNU pressed
		BTNU_TB <= '1'; wait for CLK_PERIOD * 2; BTNU_TB <= '0'; wait for CLK_PERIOD * 2;
		assert inserted_amount_TB = 10 report "Test 1: the inserted amount is not 10 cents / BTNU failed" severity error;

		-- Test Case 2: Insert 20 cents / BTNL pressed
		BTNL_TB <= '1'; wait for CLK_PERIOD * 2; BTNL_TB <= '0'; wait for CLK_PERIOD * 2;
		assert inserted_amount_TB = 10 + 20 report "Test 2: the inserted amount is not 30 cents / BTNL failed" severity error;

		-- Test Case 3: Insert 50 cents / BTNR pressed
		BTNR_TB <= '1'; wait for CLK_PERIOD * 2; BTNR_TB <= '0'; wait for CLK_PERIOD * 2;
		assert inserted_amount_TB = 10 + 20 + 50 report "Test 3: the inserted amount is not 50 cents / BTNR failed" severity error;

		-- Test Case 4: Insert 100 cents / BTND pressed
		BTND_TB <= '1'; wait for CLK_PERIOD * 2; BTND_TB <= '0'; wait for CLK_PERIOD * 2;
		assert inserted_amount_TB = 10 + 20 + 50 + 100 report "Test 4: the inserted amount is not 100 cents / BTND failed" severity error;

		-- Test Case 5: Reset Test
		reset_TB <= '1';
		wait for CLK_PERIOD * 2;
		reset_TB <= '0';
		wait for CLK_PERIOD * 2;
		assert inserted_amount_TB = 0 report "Test 5: Reset failed" severity error;

		report "All Tests passed / Coin_Handler component verified" severity note;
		wait;
	end process;
end behavioral;

