library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Manager_TB is
end Display_Manager_TB;

architecture behavioral of Display_Manager_TB is
	
	component Display_Manager
		port(
			clk : in std_logic;
			reset : in std_logic;
			display_text : in std_logic_vector(63 downto 0);
			SEG : out std_logic_vector(6 downto 0);
			AN : out std_logic_vector(7 downto 0);
			dp : out std_logic
		);
	end component;

	signal clk_TB		: std_logic := '0';
	signal reset_TB		: std_logic := '0';
	signal display_text_TB	: std_logic_vector(63 downto 0) := (others => '0');
	signal SEG_TB		: std_logic_vector(6 downto 0);
	signal AN_TB		: std_logic_vector(7 downto 0);
	signal dp_TB		: std_logic;

	constant CLK_PERIOD : time := 10 ns;

	function string_to_ascii(s : string) return std_logic_vector is 
		variable result : std_logic_vector(63 downto 0) := (others => '0');
	begin
		for i in 0 to 7 loop
			if i < s'length then
				result(63 - i*8 downto 56 - i*8) := std_logic_vector(to_unsigned(character'pos(s(i+1)), 8));
			else
				result(63 - i*8 downto 56 - i*8) := x"20";
			end if;
		end loop;
		return result;
	end function;

begin

	DUT: Display_Manager
		port map(
			clk 		=> clk_TB,
			reset 		=> reset_TB,
			display_text 	=> display_text_TB,
			SEG 		=> SEG_TB,
			AN 		=> AN_TB,
			dp 		=> dp_TB
		);

	clk_process : process
	begin
		clk_TB <= '0';
		wait for CLK_PERIOD / 2;
		clk_TB <= '1';
		wait for CLK_PERIOD / 2;
	end process;

	stimulate_process : process
		variable str_value : std_logic_vector(63 downto 0);
	begin
		-- Test 1: "01234567"
		str_value := string_to_ascii("01234567");
		display_text_TB <= str_value;
		wait for 20 ms;

		-- Test 2: "89 AEObc"
		str_value := string_to_ascii("89 AEObc");
		display_text_TB <= str_value;
		wait for 20 ms;

		-- Test 3: "ghlor   "
		str_value := string_to_ascii("ghlor   ");
		display_text_TB <= str_value;
		wait for 20 ms;

		-- Test 4: "colA0130"
		str_value := string_to_ascii("colA0130");
		display_text_TB <= str_value;
		wait for 20 ms;

		-- Test 5: "bEEr0150"
		str_value := string_to_ascii("bEER0150");
		display_text_TB <= str_value;
		wait for 20 ms;

		-- Test 6: "h2o 0090"
		str_value := string_to_ascii("h2o 0000");
		display_text_TB <= str_value;
		wait for 20 ms;

		wait;
	end process;
end behavioral;


	
