library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Manager_tb is
end Display_Manager_tb;

architecture behavior of Display_Manager_tb is

    -- Component under test
    component Display_Manager
        Port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            display_text : in  std_logic_vector(63 downto 0);
            SEG          : out std_logic_vector(6 downto 0);
            AN           : out std_logic_vector(7 downto 0);
            dp           : out std_logic
        );
    end component;

    -- Signals
    signal clk_tb          : std_logic := '0';
    signal reset_tb        : std_logic := '0';
    signal display_text_tb : std_logic_vector(63 downto 0) := (others => '0');
    signal SEG_tb          : std_logic_vector(6 downto 0);
    signal AN_tb           : std_logic_vector(7 downto 0);
    signal dp_tb           : std_logic;

    -- Clock period (100 MHz)
    constant clk_period : time := 10 ns;

    -- Helper function
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

    -- Instantiate DUT
    uut : Display_Manager
        port map (
            clk          => clk_tb,
            reset        => reset_tb,
            display_text => display_text_tb,
            SEG          => SEG_tb,
            AN           => AN_tb,
            dp           => dp_tb
        );

    -- Clock process
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc : process
        variable str_value : std_logic_vector(63 downto 0);
    begin
        -- Test 1: '01234567'
        str_value := string_to_ascii("01234567");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- Test 2: '89 AEObc'
        str_value := string_to_ascii("89 AEObc");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- Test 3: 'ghlor   '
        str_value := string_to_ascii("ghlor   ");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- Test 4: 'colA0130'
        str_value := string_to_ascii("colA0130");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- Test 5: 'bEEr0150'
        str_value := string_to_ascii("bEEr0150");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- Test 6: 'h2o 0090'
        str_value := string_to_ascii("h2o 0090");
        display_text_tb <= str_value;
	wait for 20 ms;

        -- End simulation
        wait;
    end process;

end behavior;

